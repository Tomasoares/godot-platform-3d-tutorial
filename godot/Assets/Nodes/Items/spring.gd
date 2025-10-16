extends Node3D

@export var potency := 1.5

func _on_action_area_area_entered(area: Area3D) -> void:
	var player_collision := area as AttackCollision
	if !player_collision:
		return
		
	var player := player_collision.player
	player.velocity.y = player.JUMP_VELOCITY * potency
	$AnimationPlayer.play("push")
	SoundManager.play_bump_sound()
