extends Control

func _ready() -> void:
	GlobalEventBus.shape_selected.emit("Rectangle")
	GlobalEventBus.mode_selected.emit("Draw")
	GlobalEventBus.draw_mode_selected.emit("Text")
