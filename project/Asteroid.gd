extends KinematicBody2D

var screensize

func _ready():
	screensize = get_viewport().get_visible_rect().size
	
func _process(delta):
	
#	move_and_collide(Vector2(-1,-1).rotated(rotation))
	
	if(position.x < 0):
		position.x = screensize.x
	if(position.x > screensize.x):
		position.x = 0
	if(position.y < 0):
		position.y = screensize.y
	if(position.y > screensize.y):
		position.y = 0