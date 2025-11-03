class_name Rectangle
extends Shape

func _draw():
	if points.size() == 2:
		var rect = Rect2(points[0], points[1] - points[0]).abs()
		draw_rect(rect, color, false, stroke_width)
