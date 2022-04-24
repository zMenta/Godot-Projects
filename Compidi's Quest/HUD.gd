extends CanvasLayer

func _ready():
	yield(get_tree().create_timer(3),"timeout")
	$Title.hide()
	$ControlLabel.hide()

func update_score_label(score: int) -> void:
	$ScoreLabel.text = str(score)

