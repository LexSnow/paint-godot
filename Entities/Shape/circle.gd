class_name Circle
extends Shape

func _draw_shape():
	if points.size() == 2:
		var radius = points[0].distance_to(points[1])
		draw_circle(points[0], radius, color, false, stroke_width)

func _draw_selection():
	if points.size() == 2:
		var radius = points[0].distance_to(points[1])
		var highlight_color = Color(0.2, 0.8, 1.0)
		var highlight_width = stroke_width + 2
		draw_circle(points[0], radius, highlight_color, false, highlight_width)
		_draw_shape()
