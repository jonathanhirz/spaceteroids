extends Node2D

var score

func _ready():
	score = 0
	$HUD.update_score(score)

func _process(delta):
	if(Input.is_key_pressed(KEY_ESCAPE)):
		get_tree().quit()

	if(Input.is_key_pressed(KEY_R)):
		get_tree().reload_current_scene()

func been_hit_update_score():
	score += 1
	$HUD.update_score(score)

func _on_Ship_dead():
	$HUD/Instructions2.visible = false
	$HUD/Death.visible = true
