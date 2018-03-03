extends KinematicBody2D

func _process(delta):
	rotate(delta * 10)