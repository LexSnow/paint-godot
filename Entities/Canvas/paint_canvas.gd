extends Control

const RectangleScene = preload("res://Entities/Shape/rectangle.tscn")
const CircleScene = preload("res://Entities/Shape/circle.tscn")
const LineScene = preload("res://Entities/Shape/line.tscn")

var current_shape_scene: PackedScene = LineScene
var is_drawing: bool = false
var current_shape_instance: Node2D = null
var start_point: Vector2 = Vector2.ZERO
var selected_shape: Node2D = null
var current_color: Color = Color.BLACK

func _ready():
	GlobalEventBus.shape_selected.connect(_on_shape_type_selected)
	GlobalEventBus.shape_clicked.connect(_on_shape_clicked)
	GlobalEventBus.color_change_requested.connect(_on_color_change_requested)

func _on_color_change_requested(color: Color):
	current_color = color

func _on_shape_type_selected(shape_type: String):
	match shape_type:
		"Rectangle":
			current_shape_scene = RectangleScene
		"Circle":
			current_shape_scene = CircleScene
		"Line":
			current_shape_scene = LineScene

func _on_shape_clicked(shape: Node2D):
	if selected_shape:
		selected_shape.deselect()
	selected_shape = shape
	selected_shape.select()

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			var mouse_pos = get_local_mouse_position()
			if get_rect().has_point(mouse_pos):
				start_drawing(mouse_pos)
		else: # Mouse button released
			if is_drawing:
				stop_drawing(get_local_mouse_position())

	elif event is InputEventMouseMotion and is_drawing:
		update_drawing(get_local_mouse_position())

func start_drawing(position: Vector2):
	is_drawing = true
	start_point = position

	if current_shape_scene:
		current_shape_instance = current_shape_scene.instantiate()
		current_shape_instance.color = current_color
		add_child(current_shape_instance)
		current_shape_instance.update_shape([start_point, start_point])

func update_drawing(position: Vector2):
	if current_shape_instance:
		current_shape_instance.update_shape([start_point, position])

func stop_drawing(position: Vector2):
	if is_drawing:
		is_drawing = false
		if current_shape_instance:
			current_shape_instance.update_shape([start_point, position])
			current_shape_instance = null
