extends CanvasLayer

func _ready():
	$AnimationPlayer.play("fade_instructions")

func update_score(score):
	# this gets called from a signal when an asteroid is destroyed
	$Score.text = "Score: " + str(score)