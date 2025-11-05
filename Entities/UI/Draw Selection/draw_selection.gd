extends VBoxContainer
## Controls the Draw Selection


@onready var text_container: HBoxContainer = $TextContainer


func _on_text_toggled(toggled_on: bool) -> void:
	if toggled_on:
		text_container.visible = true
		GlobalEventBus.draw_mode_selected.emit("Text")
	else:
		text_container.visible = false


func _on_interactive_pressed() -> void:
	GlobalEventBus.draw_mode_selected.emit("Interactive")


func _on_points_pressed() -> void:
	GlobalEventBus.draw_mode_selected.emit("Points")
