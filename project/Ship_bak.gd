extends RigidBody2D

export var speed = 10

var acceleration = Vector2()
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

func _physics_process(delta):
	
	# get input and apply movement vector to ship
	acceleration = Vector2(_get_axis("horizontal"), _get_axis("vertical"))
	apply_impulse(Vector2(0, 0), acceleration * speed)

	# turn the ship based on its velocity.
	# still need to stop this from resetting angle at 0
	if(abs(linear_velocity.x) > 0.0001 || abs(linear_velocity.y) > 0.0001):
		rotation_degrees = _get_angle()
		
	# ship animations
	if(acceleration.length() > 0.1):
		$AnimatedSprite.animation = "engines_on"
	else:
		$AnimatedSprite.animation = "idle"
	
func _integrate_forces(state):
	var xform = state.get_transform()
	# check if player is at edges of screen, and wrap around
	if xform.origin.x > screensize.x:
		xform.origin.x = 0
	if xform.origin.x < 0:
		xform.origin.x = screensize.x
	if xform.origin.y > screensize.y:
		xform.origin.y = 0
	if xform.origin.y < 0:
		xform.origin.y = screensize.y
	state.set_transform(xform)
	
func _get_angle():
	# degree angle of player ship, based on velocity vector
	return rad2deg(atan2(linear_velocity.x, -linear_velocity.y))
	
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


func _on_Area2D_body_entered(body):
	# death animation, game over/reset
#	queue_free()
	pass