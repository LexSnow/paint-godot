class_name Line
extends Shape

func _draw_shape():
	if points.size() > 1:
		for i in range(points.size() - 1):
			draw_line(points[i], points[i+1], color, stroke_width)

func _draw_selection():
	if points.size() > 1:
		var highlight_color = Color(0.2, 0.8, 1.0)
		var highlight_width = stroke_width + 2
		for i in range(points.size() - 1):
			draw_line(points[i], points[i + 1], highlight_color, highlight_width)
		_draw_shape()
