extends RigidBody2D

signal been_hit

var screensize
var _x
var _y

func _ready():
	screensize = get_viewport().get_visible_rect().size
	_x = ((randi() % 10 + 1) - 5) * 15
	_y = ((randi() % 10 + 1) - 5) * 15
	# random movement direction
	set_linear_velocity(Vector2(_x,_y).rotated(rotation))

	# after defining a signal variable, you connect it to another node in code like this
	connect("been_hit", get_tree().get_root().get_node("Main"), "been_hit_update_score")

func explode():
	# when the asteroid is hit, it emits this signal, which has been connected above
	emit_signal("been_hit")
	queue_free()

func _integrate_forces(state):
	var xform = state.get_transform()
	# check if asteroid is at edges of screen, and wrap around
	# this is how you reset the position of a RigidBody2D
	if xform.origin.x > screensize.x:
		xform.origin.x = 0
	if xform.origin.x < 0:
		xform.origin.x = screensize.x
	if xform.origin.y > screensize.y:
		xform.origin.y = 0
	if xform.origin.y < 0:
		xform.origin.y = screensize.y
	state.set_transform(xform)