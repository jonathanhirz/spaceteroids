extends KinematicBody2D

export var speed = 12

var acceleration = Vector2()
var velocity = Vector2()
var screensize

func _ready():
	set_physics_process(true)
	screensize = get_viewport().get_visible_rect().size

func _process(delta):
	#shooting lasers
	if(Input.is_action_just_pressed("shoot")):
		var laser = preload("res://Laser.tscn").instance()
		laser.set_position($Gun.global_position)
		laser.set_rotation($Gun.get_parent().rotation)
		get_tree().get_root().add_child(laser)
		
	if(position.x < 0):
		position.x = screensize.x
	if(position.x > screensize.x):
		position.x = 0
	if(position.y < 0):
		position.y = screensize.y
	if(position.y > screensize.y):
		position.y = 0

func _physics_process(delta):
	
	# get input and apply movement vector to ship
	acceleration = Vector2(_get_axis("horizontal"), _get_axis("vertical"))
	velocity += acceleration * delta
	var collision = move_and_collide(velocity * speed)
	velocity *= 0.9
	
	# ship collision. if hit asteroid or fireball or dragon, ?YOUDIE?
	if(collision):
		if(collision.collider.is_in_group("asteroid")):
			queue_free()

	# turn the ship based on its velocity.
	# still need to stop this from resetting angle at 0
	if(abs(velocity.x) > 0.0001 || abs(velocity.y) > 0.0001):
		rotation_degrees = _get_angle()
		
	# ship animations
	if(velocity.length() > 0.1):
		$AnimatedSprite.animation = "engines_on"
	else:
		$AnimatedSprite.animation = "idle"

	
func _get_angle():
	# degree angle of player ship, based on velocity vector
	return rad2deg(atan2(velocity.x, -velocity.y))
	
func _get_axis(orientation):
	# input axis for key presses
	if(orientation == "horizontal"):
		if(Input.is_action_pressed("left")):
			return -1
		elif(Input.is_action_pressed("right")):
			return 1
		else:
			return 0
	if(orientation == "vertical"):
		if(Input.is_action_pressed("up")):
			return -1
		elif(Input.is_action_pressed("down")):
			return 1
		else:
			return 0