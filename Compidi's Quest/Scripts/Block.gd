extends StaticBody2D

var screen_size 
var rect_size_x

func _ready() -> void:
	screen_size = get_viewport_rect().size
	rect_size_x = $ColorRect.get_size().x
	
	$ColorRect.set_size(Vector2(rect_size_x , screen_size.y))



func _on_Area2D_body_shape_entered(body_rid: RID, body: Node, body_shape_index: int, local_shape_index: int) -> void:
	print("body entered:", body)
	
	yield(get_tree().create_timer(2),"timeout")
	
	print(body)
	
