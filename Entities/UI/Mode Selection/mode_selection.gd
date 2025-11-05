extends VBoxContainer
## Controls mode selection

func _on_draw_pressed() -> void:
	GlobalEventBus.mode_selected.emit("Draw")


func _on_edit_pressed() -> void:
	GlobalEventBus.mode_selected.emit("Edit")
