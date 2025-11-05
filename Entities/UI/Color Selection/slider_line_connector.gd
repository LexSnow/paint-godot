extends HBoxContainer

signal value_changed_for_color

@export var slider: Slider
@export var line_edit: LineEdit

func _ready() -> void:
	slider.value_changed.connect(_on_slider_value_changed)
	line_edit.text_submitted.connect(_on_value_submitted)
	
func _on_slider_value_changed(value):
	line_edit.text = str(int(value))
	value_changed_for_color.emit()
	
func _on_value_submitted(new_text):
	var num = float(new_text)
	num = clamp(num, slider.min_value, slider.max_value)
	slider.value = num
	line_edit.text = str(int(num))
	value_changed_for_color.emit()
