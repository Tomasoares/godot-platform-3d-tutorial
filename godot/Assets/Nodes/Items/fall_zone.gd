class_name FallZone
extends Area3D

@export var lives_manager : LivesManager

func _on_body_entered(body: Node3D) -> void:
	SoundManager.play_player_die()
	
	if lives_manager:
		lives_manager.lose_try()
