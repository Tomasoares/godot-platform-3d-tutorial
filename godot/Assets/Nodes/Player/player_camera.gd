class_name CameraController
extends Node

@export var camera_controller : Node3D
@export var spring_arm: SpringArm3D
@export var player : CharacterBody3D
@export var armature : Node3D

func init() -> void:
	pass
	
func handle_camera(delta: float) -> void:
	turn()
	
	if no_camera_input():
		adjust_to_player_movement(delta)
	
	follow()
	
func turn() -> void:
	var input_dir := Input.get_vector("cam_left", "cam_right", "cam_up", "cam_down")
	var no_movement := Vector2.ZERO
	if input_dir == no_movement:
		return
		
	camera_controller.rotate_y(Global.get_final_camera_sensitivity_for_joypad_y(input_dir.x))
	spring_arm.rotate_x(Global.get_final_camera_sensitivity_for_joypad_x(input_dir.y))
	spring_arm.rotation.x = clamp(spring_arm.rotation.x, deg_to_rad(-30), deg_to_rad(30))
	
func no_camera_input() -> bool:
	var input_dir := Input.get_vector("cam_left", "cam_right", "cam_up", "cam_down")
	var no_movement := Vector2.ZERO
	if input_dir == no_movement:
		weight = 0.01
		return true
		
	return false
	
var weight = 0.05

func adjust_to_player_movement(delta: float) -> void:
	var player_velocity_xz = Vector3(player.velocity.x, 0, player.velocity.z)
	var current_speed = player_velocity_xz.length()
	
	if current_speed < 8.0:
		return
		
	#get the angle of where the character is running
	#add 90 degrees to adjust to camera angle reference
	var target_angle_rad = atan2(-player_velocity_xz.x, -player_velocity_xz.z)
	var target_angle_deg = rad_to_deg(target_angle_rad)
	var current_angle = camera_controller.global_rotation.y

	weight = lerp(weight, 0.1, 0.01)
	camera_controller.global_rotation.y = lerp_angle(
			current_angle,
			deg_to_rad(target_angle_deg),
			weight
		)
		
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

func _input(event: InputEvent):
	if event is InputEventMouseMotion:
		camera_controller.rotation.y -= event.relative.x / Global.get_final_camera_sensitivity_for_mouse_x()
		camera_controller.rotation.x -= event.relative.y / Global.get_final_camera_sensitivity_for_mouse_y()
		camera_controller.rotation.x = clamp(camera_controller.rotation.x, deg_to_rad(-30), deg_to_rad(30))
		
	if event.is_action_pressed("cam_adjust"):
		camera_controller.global_rotation.y = armature.global_rotation.y
		camera_controller.global_rotation.x = clamp(armature.global_rotation.x, deg_to_rad(-30), deg_to_rad(30))
