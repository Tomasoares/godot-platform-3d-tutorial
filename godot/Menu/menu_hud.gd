extends Node2D

func _ready() -> void:
	SoundManager.play_main_menu_music()
	$Control/Play.grab_focus()

func _on_play_pressed() -> void:
	SoundManager.stop_main_menu_music()
	Global.begin_game()

func _on_exit_pressed() -> void:
	get_tree().quit()
