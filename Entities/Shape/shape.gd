class_name Shape
extends Node2D
## Abstract class for drawable shapes

## The color of the shape.
var color: Color = Color.BLACK

## The width of the stroke.
var stroke_width: float = 3.0

## The points that define the shape, in local coordinates.
var points: PackedVector2Array = []
var selected: bool = false

@onready var area = $Area2D
@onready var collision_shape = $Area2D/CollisionShape2D

func _ready() -> void:
	pass

func _draw_shape():	pass
	
func _draw_selection():
	pass

func _draw():
	_draw_shape()
	if selected:
		_draw_selection()


func update_shape(new_points: PackedVector2Array):
	points = new_points
	update_collision_shape()
	queue_redraw()

func update_collision_shape():
	# This method is overridden by subclasses
	pass


func _on_area_2d_input_event(_viewport: Node, _event: InputEvent, _shape_idx: int) -> void:
	if _event is InputEventMouseButton and _event.pressed and _event.button_index == MOUSE_BUTTON_LEFT:
		_select()

func _select() -> void:
	selected = true
	queue_redraw()
	
func _deselect():
	selected = false
	queue_redraw()
