class_name LivesManager
extends Node

@export var hud : HudManager
@export var tries_amount := 5

func _ready() -> void:
	hud.update_lives(Global.current_lives)

func lose_try() -> void:
	if Global.current_lives > 0:
		Global.current_lives -= 1
		get_tree().reload_current_scene()
	else:
		Global.game_over()

func add_extra_try() -> void:
	Global.current_lives += 2
	hud.update_lives(Global.current_lives)
