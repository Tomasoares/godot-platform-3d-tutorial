extends SpringArm3D

@export var camera: Camera3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	camera.global_position = lerp(camera.global_position, $SpringArmPosition.global_position, 0.05)
	camera.global_rotation = lerp(camera.global_rotation, $SpringArmPosition.global_rotation, 0.05)
