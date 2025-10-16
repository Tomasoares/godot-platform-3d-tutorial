extends Area3D

@export var push_power := 6.0
@export var player : CharacterBody3D

func _on_body_entered(body: Node) -> void:
	var rigid_body := body as RigidBody3D
	if !rigid_body:
		return
		
	var velocity := Vector3(player.velocity.x, 0, player.velocity.z)
	var push_direction = velocity.normalized()
	if abs(velocity.length()) > 4:
		SoundManager.play_box_kick_sound()
		rigid_body.apply_central_impulse(push_direction * push_power)
