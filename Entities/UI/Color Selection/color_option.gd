extends VBoxContainer

@onready var option_button: OptionButton = $OptionButton
@onready var rgb_sliders: VBoxContainer = $RGBSliders
@onready var cmyk_sliders: VBoxContainer = $CMYKSliders

var current_color: Color = Color(1, 1, 1)

func _ready() -> void:
	_toggle_color_mode(option_button.get_selected_id())
	for slider in get_tree().get_nodes_in_group("rgb_sliders"):
		slider.value_changed_for_color.connect(_on_rgb_changed)
	for slider in get_tree().get_nodes_in_group("cmyk_sliders"):
		slider.value_changed_for_color.connect(_on_cmyk_changed)

func _on_option_button_item_selected(index: int) -> void:
	_toggle_color_mode(index)

func _toggle_color_mode(index: int) -> void:
	var rgb_mode := index == 0
	rgb_sliders.visible = rgb_mode
	cmyk_sliders.visible = not rgb_mode

	if rgb_mode:
		_convert_cmyk_to_rgb()
		_set_rgb_sliders_from_color()
	else:
		var cmyk = _rgb_to_cmyk(current_color)
		_set_cmyk_sliders(cmyk)

func _on_rgb_changed():
	current_color = _get_rgb_from_sliders()
	GlobalEventBus.color_change_requested.emit(current_color)

	# update CMYK view but do NOT round trip convert back
	if not rgb_sliders.visible: return
	var cmyk = _rgb_to_cmyk(current_color)
	_set_cmyk_sliders(cmyk)

func _on_cmyk_changed():
	if not cmyk_sliders.visible: return
	_convert_cmyk_to_rgb()
	_set_rgb_sliders_from_color()
	GlobalEventBus.color_change_requested.emit(current_color)

func _get_rgb_from_sliders() -> Color:
	return Color(
		rgb_sliders.get_node("RContainer/RSlider").value / 255.0,
		rgb_sliders.get_node("GContainer/GSlider").value / 255.0,
		rgb_sliders.get_node("BContainer/BSlider").value / 255.0,
	)

func _set_rgb_sliders_from_color() -> void:
	rgb_sliders.get_node("RContainer/RSlider").value = current_color.r * 255
	rgb_sliders.get_node("GContainer/GSlider").value = current_color.g * 255
	rgb_sliders.get_node("BContainer/BSlider").value = current_color.b * 255

func _set_cmyk_sliders(cmyk: Dictionary) -> void:
	cmyk_sliders.get_node("CContainer/CSlider").value = cmyk.c * 100
	cmyk_sliders.get_node("MContainer/MSlider").value = cmyk.m * 100
	cmyk_sliders.get_node("YContainer/YSlider").value = cmyk.y * 100
	cmyk_sliders.get_node("KContainer/KSlider").value = cmyk.k * 100
	
func _rgb_to_cmyk(color: Color) -> Dictionary:
	var k = 1.0 - max(color.r, max(color.g, color.b))
	if k >= 1.0:
		return {c = 0.0, m = 0.0, y = 0.0, k = 1.0}

	var c = (1.0 - color.r - k) / (1.0 - k)
	var m = (1.0 - color.g - k) / (1.0 - k)
	var y = (1.0 - color.b - k) / (1.0 - k)

	return {c = c, m = m, y = y, k = k}

func _convert_cmyk_to_rgb():
	var c = cmyk_sliders.get_node("CContainer/CSlider").value / 100.0
	var m = cmyk_sliders.get_node("MContainer/MSlider").value / 100.0
	var y = cmyk_sliders.get_node("YContainer/YSlider").value / 100.0
	var k = cmyk_sliders.get_node("KContainer/KSlider").value / 100.0

	current_color = Color(
		1.0 - min(1.0, c * (1.0 - k) + k),
		1.0 - min(1.0, m * (1.0 - k) + k),
		1.0 - min(1.0, y * (1.0 - k) + k)
		)
