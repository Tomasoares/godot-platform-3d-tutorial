class_name LookAtBehaviour
extends Node

@export var enemy_shooter : EnemyShooter
@export var armature : Node3D

var stop = false
	
func _process(delta: float) -> void:
	look_at_player()
	
func look_at_player() -> void:
	if stop:
		return
		
	var character : CharacterBody3D = enemy_shooter.get_player().get_character()
	var target_position = Vector3(-character.global_position.x, enemy_shooter.global_position.y, -character.global_position.z)
	armature.look_at(target_position, Vector3.UP)

func stop_looking_at() -> void:
	stop = true
