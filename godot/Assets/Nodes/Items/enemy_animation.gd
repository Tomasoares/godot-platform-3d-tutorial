class_name EnemyAnimation
extends Node

@export var animation_player: AnimationPlayer
@export var dying_duration := 1.0
var dying = false

func handle_animation(delta: float) -> void:
	if not dying and not animation_player.is_playing():
		animation_player.play("blob")

func play_death_animation() -> Signal:
	dying = true
	animation_player.play("squash")
	return get_tree().create_timer(1.0).timeout 
	
