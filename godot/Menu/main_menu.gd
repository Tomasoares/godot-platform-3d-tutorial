extends Control

@export var level_select_window : Control

func _ready() -> void:
	$Play.grab_focus()

func _on_play_pressed() -> void:
	SoundManager.stop_main_menu_music()
	Global.begin_game()

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_levels_pressed() -> void:
	visible = false
	level_select_window.visible = true

func _on_visibility_changed() -> void:
	if visible:
		$Play.grab_focus()
