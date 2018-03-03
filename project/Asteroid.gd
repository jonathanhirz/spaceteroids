extends KinematicBody2D

var screensize

func _ready():
	screensize = get_viewport().get_visible_rect().size\
	
func _process(delta):
	if(position.x < 0):
		position.x = screensize.x
	if(position.x > screensize.x):
		position.x = 0
	if(position.y < 0):
		position.y = screensize.y
	if(position.y > screensize.y):
		position.y = 0

func _on_Area2D_body_entered(body):
	print(body.name)
