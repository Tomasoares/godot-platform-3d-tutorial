extends Node3D

@export var camera_controller : Node3D
@export var player : CharacterBody3D

var weight = 0.05
var rotation_set := false
var use_automatic_camera = false
	
func handle_camera(delta: float) -> void:
	should_enable_automatic_camera()
	
	if !use_automatic_camera:
		return
	
	move_automatic_camera()
		
func should_enable_automatic_camera() -> void:
	if player_made_camera_input():
		use_automatic_camera = false
		return
		
	if is_abrupt_turn():
		use_automatic_camera = false
		return
	
	if use_automatic_camera:
		return
		
	var player_velocity_xz = Vector3(player.velocity.x, 0, player.velocity.z)
	var current_speed = player_velocity_xz.length()
	use_automatic_camera = current_speed > 9.0

func player_made_camera_input() -> bool:
	var input_dir := Input.get_vector("cam_left", "cam_right", "cam_up", "cam_down")
	var no_movement := Vector2.ZERO
	if input_dir == no_movement:
		weight = 0.01
		return false
		
	return true
	
func is_abrupt_turn() -> bool:
	var target_rotation := calculate_continuous_rotation()
	var current_angle = camera_controller.global_rotation.y
	var diff_angle = target_rotation - current_angle
	
	var wrapped_diff = fmod(diff_angle + PI, TAU) - PI
	var absolute_diff = abs(wrapped_diff)
	return absolute_diff > deg_to_rad(160)
	
func move_automatic_camera() -> void:
	var target_rotation := calculate_continuous_rotation()
	weight = lerp(weight, 0.1, 0.01)
	var current_angle = camera_controller.global_rotation.y
	camera_controller.global_rotation.y = lerp_angle(current_angle, target_rotation, weight)

func calculate_continuous_rotation() -> float:
	var player_velocity_xz = Vector3(player.velocity.x, 0, player.velocity.z)
	return atan2(-player_velocity_xz.x, -player_velocity_xz.z)
	

func _input(event: InputEvent):
	if event is InputEventMouseMotion:
		use_automatic_camera = false
		
	if event.is_action_pressed("cam_adjust") or event.is_action_pressed("cam_adjust_key"):
		use_automatic_camera = false
