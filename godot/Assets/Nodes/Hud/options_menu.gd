extends Control

@export var parent_menu : Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !visible:
		return
	
	if Input.is_action_just_pressed("pause") or Input.is_action_just_pressed("go_back"):
		go_back()
		SoundManager.play_button_go_back_sound()

func go_back() -> void:
	visible = false
	parent_menu.visible = true

func _on_go_back_button_pressed() -> void:
	go_back()

func _on_visibility_changed() -> void:
	$SensibilitySlider.value = Global.get_current_sensitivity()
	$VolumeSlider.value = Global.get_game_volume()
	$InvertXText/InvertXToggle.button_pressed = Global.invert_x
	$InvertYText/CheckButton.button_pressed = Global.invert_y
	$FullscreenText/CheckButton.button_pressed = Global.is_game_fullscreen()
	$InvertKeys/CheckButton.button_pressed = Global.is_key_map_inverted()

func _on_sensibility_slider_value_changed(value: float) -> void:
	Global.set_current_sensitivity($SensibilitySlider.value)

func _on_invert_x_toggle_toggled(toggled_on: bool) -> void:
	Global.invert_x = toggled_on

func _on_check_button_toggled(toggled_on: bool) -> void:
	Global.invert_y = toggled_on

func _on_fullscreen_button_toggled(toggled_on: bool) -> void:
	Global.toggle_fullscreen(toggled_on)

func _on_volume_slider_value_changed(value: float) -> void:
	Global.set_game_volume(value)

func _on_invert_keys_check_button_toggled(toggled_on: bool) -> void:
	Global.toggle_key_map_inversion(toggled_on)
