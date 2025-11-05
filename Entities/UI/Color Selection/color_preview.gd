extends HBoxContainer

@onready var color_rect: ColorRect = $ColorRect
@onready var color_option: VBoxContainer = $ColorOption
func _ready() -> void:
	GlobalEventBus.color_change_requested.connect(_on_color_changed)
	
func _on_color_changed(color: Color):
	color_rect.color = color
