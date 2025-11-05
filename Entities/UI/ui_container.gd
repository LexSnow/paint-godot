extends VBoxContainer

@onready var shape_selection: VBoxContainer = $ShapeSelection
@onready var mode_selection: VBoxContainer = $ModeSelection
@onready var draw_selection: VBoxContainer = $DrawSelection
@onready var edit_selection: VBoxContainer = $EditSelection
@onready var color_selection: VBoxContainer = $ColorSelection

func _ready() -> void:
	GlobalEventBus.mode_selected.connect(_on_mode_selected)

func _on_mode_selected(mode: String) -> void:
	match mode:
		"Draw":
			_switch_to_draw_selection()
		"Edit":
			_switch_to_edit_selection()
		_:
			push_warning("Unknown mode: %s" % mode)

func _switch_to_draw_selection() -> void:
	draw_selection.visible = true
	edit_selection.visible = false

func _switch_to_edit_selection() -> void:
	draw_selection.visible = false
	edit_selection.visible = true
	
