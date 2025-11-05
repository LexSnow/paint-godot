extends VBoxContainer
## Controls the Edit selection

@onready var text_container: HBoxContainer = $TextContainer

func _on_text_toggled(toggled_on: bool) -> void:
	if toggled_on:
		text_container.visible = true
		GlobalEventBus.edit_mode_selected.emit("Text")
	else:
		text_container.visible = false


func _on_interactive_pressed() -> void:
	GlobalEventBus.edit_mode_selected.emit("Interactive")
