extends KinematicBody2D

var screensize
var speed = 5
var loop_counter
var max_loops = 3

func _ready():
	set_physics_process(true)
	
	screensize = get_viewport().get_visible_rect().size
	loop_counter = 0

func _process(delta):
	if(position.x < 0):
		position.x = screensize.x
		loop_counter += 1
	if(position.x > screensize.x):
		position.x = 0
		loop_counter += 1
	if(position.y < 0):
		position.y = screensize.y
		loop_counter += 1
	if(position.y > screensize.y):
		position.y = 0
		loop_counter += 1
		
	if(loop_counter >= max_loops):
		queue_free()
	
func _physics_process(delta):
	var collision = move_and_collide(Vector2(0,-1).rotated(rotation) * speed)
	if(collision):
		if(collision.collider.is_in_group("asteroid")):
			collision.collider.explode(collision.normal)
			queue_free()