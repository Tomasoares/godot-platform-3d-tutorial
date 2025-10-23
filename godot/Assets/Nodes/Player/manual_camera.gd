extends Node3D

@export var camera_controller : Node3D
@export var spring_arm: SpringArm3D
@export var armature : Node3D

func init() -> void:
	pass
	
func handle_camera(delta: float) -> void:
	if !no_camera_input():
		turn()

func no_camera_input() -> bool:
	var input_dir := Input.get_vector("cam_left", "cam_right", "cam_up", "cam_down")
	var no_movement := Vector2.ZERO
	if input_dir == no_movement:
		return true
		
	return false

func turn() -> void:
	var input_dir := Input.get_vector("cam_left", "cam_right", "cam_up", "cam_down")
	var no_movement := Vector2.ZERO
	if input_dir == no_movement:
		return
		
	camera_controller.rotate_y(Global.get_final_camera_sensitivity_for_joypad_y(input_dir.x))
	spring_arm.rotate_x(Global.get_final_camera_sensitivity_for_joypad_x(input_dir.y))
	spring_arm.rotation.x = clamp(spring_arm.rotation.x, deg_to_rad(-30), deg_to_rad(30))

func _input(event: InputEvent):
	if event is InputEventMouseMotion:
		camera_controller.rotation.y -= event.relative.x / Global.get_final_camera_sensitivity_for_mouse_x()
		camera_controller.rotation.x -= event.relative.y / Global.get_final_camera_sensitivity_for_mouse_y()
		camera_controller.rotation.x = clamp(camera_controller.rotation.x, deg_to_rad(-30), deg_to_rad(30))
		
	if event.is_action_pressed("cam_adjust") or event.is_action_pressed("cam_adjust_key"):
		camera_controller.global_rotation.y = armature.global_rotation.y
		camera_controller.global_rotation.x = clamp(armature.global_rotation.x, deg_to_rad(-30), deg_to_rad(30))
