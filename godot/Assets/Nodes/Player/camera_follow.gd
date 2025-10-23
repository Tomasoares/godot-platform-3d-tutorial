extends Node3D

@export var player : CharacterBody3D
@export var camera_controller : Node3D

func follow() -> void:
	var target_position := player.position
	var current_position = camera_controller.position
	var y_lerp_factor = 0.04
	
	if player.is_on_floor():
		y_lerp_factor = 0.07
		
	current_position.x = lerp(current_position.x, target_position.x, 0.1)
	current_position.z = lerp(current_position.z, target_position.z, 0.1)
	current_position.y = lerp(current_position.y, target_position.y, y_lerp_factor)
	
	camera_controller.position = current_position
