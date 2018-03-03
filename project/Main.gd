extends Node2D

# score system

func _process(delta):
	if(Input.is_key_pressed(KEY_ESCAPE)):
		get_tree().quit()
		
	if(Input.is_key_pressed(KEY_R)):
		get_tree().reload_current_scene()