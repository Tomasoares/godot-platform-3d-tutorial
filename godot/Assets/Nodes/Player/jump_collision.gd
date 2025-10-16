extends Area3D

@export var player : CharacterBody3D
var can_jump := false

func _on_body_entered(body: Node3D) -> void:
	can_jump = true


func _on_body_exited(body: Node3D) -> void:
	can_jump = false
	
func _input(event: InputEvent) -> void:
	if !player.alive:
		return
		
	if !event.is_action_pressed("jump"):
		return
		
	if can_jump or player.is_on_floor():
		SoundManager.play_player_jump()
		player.velocity.y = player.JUMP_VELOCITY
	
