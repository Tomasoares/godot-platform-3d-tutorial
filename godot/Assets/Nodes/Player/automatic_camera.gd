extends Node3D

@export var camera_controller : Node3D
@export var player : CharacterBody3D

var weight = 0.05
var rotation_set := false
var continuous_rotation : float
	
func handle_camera(delta: float) -> void:
	initialize_continuous_rotation()
	
	if no_camera_input():
		move_automatic_camera()
	else:
		stop_automatic_camera()
	
func initialize_continuous_rotation() -> void:
	if !rotation_set:
		rotation_set = true
		continuous_rotation = camera_controller.global_rotation.y
		
func stop_automatic_camera() -> void:
	continuous_rotation = camera_controller.global_rotation.y

func no_camera_input() -> bool:
	var input_dir := Input.get_vector("cam_left", "cam_right", "cam_up", "cam_down")
	var no_movement := Vector2.ZERO
	if input_dir == no_movement:
		weight = 0.01
		return true
		
	return false
	
func move_automatic_camera() -> void:
	var target_rotation := adjust_to_player_movement()
	weight = lerp(weight, 0.1, 0.01)
	var current_angle = camera_controller.global_rotation.y
	camera_controller.global_rotation.y = lerp_angle(current_angle, continuous_rotation, weight)
	

func adjust_to_player_movement() -> float:
	var player_velocity_xz = Vector3(player.velocity.x, 0, player.velocity.z)
	var current_speed = player_velocity_xz.length()
	
	if current_speed < 8.0:
		return continuous_rotation
		
	#get the angle of where the character is running
	#add 90 degrees to adjust to camera angle reference
	continuous_rotation = atan2(-player_velocity_xz.x, -player_velocity_xz.z)
	return continuous_rotation

func _input(event: InputEvent):
	if event is InputEventMouseMotion:
		continuous_rotation = camera_controller.global_rotation.y
		
	if event.is_action_pressed("cam_adjust") or event.is_action_pressed("cam_adjust_key"):
		continuous_rotation = camera_controller.global_rotation.y
