extends Control

@export var main_menu : Control

func _ready() -> void:
	visible = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("go_back"):
		visible = false
		main_menu.visible = true


func _on_visibility_changed() -> void:
	if visible:
		$Level1.grab_focus()


func _on_level_1_pressed() -> void:
	Global.play_individual_level("res://Levels/level_1.tscn")


func _on_level_2_pressed() -> void:
	Global.play_individual_level("res://Levels/level_2.tscn")


func _on_level_3_pressed() -> void:
	Global.play_individual_level("res://Levels/level_3.tscn")


func _on_level_4_pressed() -> void:
	Global.play_individual_level("res://Levels/level_4.tscn")


func _on_level_5_pressed() -> void:
	Global.play_individual_level("res://Levels/level_5.tscn")


func _on_level_6_pressed() -> void:
	Global.play_individual_level("res://Levels/level_6.tscn")


func _on_level_7_pressed() -> void:
	Global.play_individual_level("res://Levels/level_7.tscn")


func _on_level_8_pressed() -> void:
	Global.play_individual_level("res://Levels/level_8.tscn")


func _on_level_9_pressed() -> void:
	Global.play_individual_level("res://Levels/level_9.tscn")


func _on_level_10_pressed() -> void:
	Global.play_individual_level("res://Levels/level_10.tscn")


func _on_level_11_pressed() -> void:
	Global.play_individual_level("res://Levels/level_11.tscn")


func _on_level_12_pressed() -> void:
	Global.play_individual_level("res://Levels/level_12.tscn")
