extends HBoxContainer
## Controls the Shape Selection
	

func _on_rectangle_pressed() -> void:
	GlobalEventBus.shape_selected.emit(Rectangle.new())


func _on_circle_pressed() -> void:
	GlobalEventBus.shape_selected.emit(Circle.new())


func _on_line_pressed() -> void:
	GlobalEventBus.shape_selected.emit(Line.new())
