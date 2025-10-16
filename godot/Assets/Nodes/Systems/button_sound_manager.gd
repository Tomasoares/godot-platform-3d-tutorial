class_name ButtonSoundManager
extends Node

@export var parent_scene : Node

func _ready():
	await parent_scene.get_tree().process_frame
	var all_buttons : Array[Node] = parent_scene.find_children("", "Button", true)
	for node in all_buttons:
		var button := node as Button
		button.focus_exited.connect(_on_focus_exited_pressed.bind(button), CONNECT_DEFERRED)
		button.focus_entered.connect(_on_focus_entered_pressed.bind(), CONNECT_DEFERRED)
		button.pressed.connect(_on_button_pressed.bind())
		
	var all_sliders : Array[Node] = parent_scene.find_children("", "HSlider", true)
	for node in all_sliders:
		var button := node as HSlider
		button.focus_exited.connect(_on_focus_exited_pressed.bind(button), CONNECT_DEFERRED)

var pressed := false

func _on_button_pressed():
	SoundManager.play_button_apply_sound()
	pressed = true
	

func _on_focus_exited_pressed(button: CanvasItem):
	if pressed:
		return
		
	if !button.get_parent().visible:
		return
		
	SoundManager.play_button_selected_sound()
	
func _on_focus_entered_pressed():
		pressed = false
