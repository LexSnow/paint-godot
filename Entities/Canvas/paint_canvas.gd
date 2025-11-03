extends Control
## Singleton for managing paint_canvas

var is_drawing: bool = false
var current_shape: Shape = null
var start_point: Vector2 = Vector2.ZERO

func _ready():
	GlobalEventBus.shape_selected.connect(_on_shape_selected)

func _on_shape_selected(shape: Shape):
	current_shape = shape

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_pressed():
				start_drawing(get_global_mouse_position())
			else:
				stop_drawing(get_global_mouse_position())
	elif event is InputEventMouseMotion and is_drawing:
		update_drawing(get_global_mouse_position())

func start_drawing(_position: Vector2):
	is_drawing = true
	start_point = _position

	if current_shape:
		add_child(current_shape)
		current_shape.update_shape([start_point, start_point])

func update_drawing(_position: Vector2):
	if current_shape:
		current_shape.update_shape([start_point, _position])

func stop_drawing(_position: Vector2):
	if is_drawing:
		is_drawing = false
		if current_shape:
			current_shape.update_shape([start_point, _position])
			current_shape = null
