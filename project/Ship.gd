extends KinematicBody2D

signal dead

export var speed = 12

var acceleration = Vector2()
var velocity = Vector2()
var screensize

func _ready():
	set_physics_process(true)
	# screensize variable is used for wrapping ship around the edges of the screen
	screensize = get_viewport().get_visible_rect().size

func _process(delta):
	#shooting lasers
	if(Input.is_action_just_pressed("shoot")):
		var laser = preload("res://Laser.tscn").instance()
		#Gun is a position 2D attached to the ship, useful for spawn location
		laser.set_position($Gun.global_position)
		laser.set_rotation($Gun.get_parent().rotation)
		get_tree().get_root().add_child(laser)

	# wrap ship around screen when it hits the edge
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
	acceleration = Vector2(get_axis("horizontal"), get_axis("vertical"))
	velocity += acceleration * delta
	var collision = move_and_collide(velocity * speed)
	velocity *= 0.9

	# ship collision. there's still a bug here, if the ship is not moving and an asteroid
	# hits you, you won't die. this is because the collision variable and information
	# is generated by the move_and_collide() function
	if(collision):
		if(collision.collider.is_in_group("asteroid")):
			emit_signal("dead")
			queue_free()

	# turn the ship based on its velocity.
	# still need to stop this from resetting angle at 0
	if(abs(velocity.x) > 0.0001 || abs(velocity.y) > 0.0001):
		rotation_degrees = get_angle()

	# ship animations
	if(velocity.length() > 0.1):
		$AnimatedSprite.animation = "engines_on"
	else:
		$AnimatedSprite.animation = "idle"


func get_angle():
	# degree angle of player ship, based on velocity vector
	return rad2deg(atan2(velocity.x, -velocity.y))

func get_axis(orientation):
	# input axis for key presses
	# this is a pretty basic and verbose way to define keyboard movement axis that report
	# a range of (-1,1)
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