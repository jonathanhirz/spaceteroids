extends CanvasLayer

func _ready():
	$AnimationPlayer.play("fade_instructions")

func update_score(score):
	$Score.text = "Score: " + str(score)