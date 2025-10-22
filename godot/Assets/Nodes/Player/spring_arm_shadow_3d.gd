extends SpringArm3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_equal_approx(spring_length, get_hit_length()):
		$Shadow/MeshInstance3D.visible = false
	else:
		$Shadow/MeshInstance3D.visible = true
