extends Label

func _ready():
	var timer = get_node("Timer")
	text = timer.wait_time
	
#func _process(delta):
#	text = timer.wait_time
