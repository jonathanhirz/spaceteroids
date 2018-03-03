extends KinematicBody2D

# move across the screen
# fire rounds of three fireballs at player. calculate vector to player
# die if gets hit a few times

func _ready():
	set_physics_process(true)
	pass
	
func _physics_process(delta):
	move_local_x(-0.65)
