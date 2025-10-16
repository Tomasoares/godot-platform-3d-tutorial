extends Node2D

func _ready() -> void:
	SoundManager.play_game_over_music()
	$Control/GoToMenu.grab_focus()
	pass

func _process(delta: float) -> void:
	pass

func _on_go_to_menu_pressed() -> void:
	Global.go_to_main_menu()

func _on_exit_pressed() -> void:
	get_tree().quit()
