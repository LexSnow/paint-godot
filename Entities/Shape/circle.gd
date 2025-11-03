class_name Circle
extends Shape

func _draw():
	if points.size() == 2:
		var radius = points[0].distance_to(points[1])
		draw_circle(points[0], radius, color, false)
