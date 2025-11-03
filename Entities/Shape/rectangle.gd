class_name Rectangle
extends Shape

func _draw_shape():
	if points.size() == 2:
		var rect = Rect2(points[0], points[1] - points[0]).abs()
		draw_rect(rect, color, false, stroke_width)
	
func _draw_selection():
	if points.size() == 2:
		var rect = Rect2(points[0], points[1] - points[0]).abs()
		var highlight_color = Color(0.2, 0.8, 1.0)
		var highlight_width = stroke_width + 2
		draw_rect(rect, highlight_color, false, highlight_width)
		_draw_shape()
