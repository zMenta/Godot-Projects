extends StaticBody2D

signal point_made

var screen_size 
var rect_size_x


func _ready() -> void:
	# Signal connection
	connect("point_made", owner, "_on_point_made")
	
	# Making the block color reach the end of the screen.
	screen_size = get_viewport_rect().size
	rect_size_x = $ColorRect.get_size().x
	
	$ColorRect.set_size(Vector2(rect_size_x , screen_size.y))


func _on_Area2D_body_entered(body: Node) -> void:
	yield(get_tree().create_timer(2),"timeout")
	
	if $Area2D.overlaps_body(body):
		emit_signal("point_made")


func move(distance: Vector2):
	self.position += distance
	self.integra
