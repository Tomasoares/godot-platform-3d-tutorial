extends SpringArm3D

@export var camera: Camera3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var new_target_position = $SpringArmPosition.global_position
	camera.global_position = lerp(camera.global_position, new_target_position, 0.5)
	camera.global_rotation = lerp(camera.global_rotation, $SpringArmPosition.global_rotation, 0.5)
