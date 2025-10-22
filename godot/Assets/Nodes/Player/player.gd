class_name Player
extends Node3D

@export var lives_manager : LivesManager

var dying = false

func get_character() -> CharacterBody3D:
	return $Character

func get_marker_global_position() -> Vector3:
	return $Character/Armature/ShootingTarget.global_position
	
func lose_life() -> void:
	if dying:
		return
		
	dying = true
	if lives_manager:
		lives_manager.lose_try()
