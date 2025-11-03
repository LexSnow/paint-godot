class_name Line
extends Shape

func _draw():
	if points.size() > 1:
		for i in range(points.size() - 1):
			draw_line(points[i], points[i+1], color, stroke_width)
