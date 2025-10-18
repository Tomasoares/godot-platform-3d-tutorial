class_name LookAtBehaviour
extends Node

@export var enemy : CharacterBody3D
@export var armature : Node3D

var stop = false
	
func _process(delta: float) -> void:
	look_at_player()
	
func look_at_player() -> void:
	if stop:
		return
		
	if distance_from_player_minus_y() < 1:
		return
		
	var player_character : CharacterBody3D = enemy.get_player().get_character()
	var target_position = Vector3(player_character.global_position.x, enemy.global_position.y, player_character.global_position.z)
	armature.look_at(target_position, Vector3.UP)
	armature.rotate_y(PI)

func stop_looking_at() -> void:
	stop = true
	
func distance_from_player_minus_y() -> float:
	var player : CharacterBody3D = enemy.get_player().get_character()
	var player_position := Vector3(player.global_position.x, 0, player.global_position.z)
	var enemy_position := Vector3(enemy.global_position.x, 0, enemy.global_position.z)
	var distance_from_player := player_position.distance_to(enemy_position)
	return distance_from_player
