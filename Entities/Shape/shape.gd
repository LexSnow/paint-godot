@abstract class_name Shape
extends Node2D
## Abstract class for drawable shapes

## The color of the shape.
var color: Color = Color.BLACK

## The width of the stroke.
var stroke_width: float = 1.0

## The points that define the shape, in local coordinates.
var points: PackedVector2Array = []


func _ready() -> void:
	GlobalEventBus.color_change_requested.connect(_change_color)

func _change_color(_color: Color):
	self.color = _color
	queue_redraw()
	 

# This function is responsible for drawing the shape.
# It should be overridden by subclasses.
func _draw():
	pass


# Call this method to update the shape's geometry and redraw it.
func update_shape(new_points: PackedVector2Array):
	points = new_points
	queue_redraw()
