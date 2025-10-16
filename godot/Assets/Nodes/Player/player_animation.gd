class_name PlayerAnimation
extends Node

@export var player: CharacterBody3D
@export var animationPlayer: AnimationPlayer
@export var camera: Node3D

const JUMP_BUTTON := "ui_accept"

func handle_animation(delta: float) -> void:
	var moving : bool = (abs(player.velocity.x) > 0.2 or abs(player.velocity.z) > 0.2)
	var in_slow_speed : bool = moving and (abs(player.velocity.x) < 3.0 and abs(player.velocity.z) < 3.0)
	var in_fast_speed : bool = (abs(player.velocity.x) > 7.0 or abs(player.velocity.z) > 7.0)
	
	var jump := Input.is_action_just_pressed(JUMP_BUTTON) and player.is_on_floor()
	var walk := player.is_on_floor() and in_slow_speed
	var run := moving and player.is_on_floor() and !in_fast_speed
	var runFast := moving and player.is_on_floor()
	var fall := !player.is_on_floor()
	var idle := player.is_on_floor()

	if jump:
		animationPlayer.play("jump")
	elif walk:
		animationPlayer.play("walk")
	elif run:
		animationPlayer.play("run")
	elif runFast:
		animationPlayer.play("run", -1, 2)
	elif fall:
		animationPlayer.play("fall")
	elif idle:
		animationPlayer.play("idle")
	
func play_death_animation() -> Signal:
	player.bounce()
	animationPlayer.play("hurt")
	
	#Create turning animation
	(
		create_tween()
			.tween_property(player, "rotation_degrees", Vector3(90,0,0),0.2)
			.as_relative()
	)
	
	return get_tree().create_timer(2.0).timeout
