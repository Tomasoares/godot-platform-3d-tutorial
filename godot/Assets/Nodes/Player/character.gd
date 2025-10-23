class_name PlayerCharacter
extends CharacterBody3D

@export var camera_controller : CameraController
@export var player : Player
var alive := true
var target_final_speed := Vector3()

const SPEED = 10
const JUMP_VELOCITY = 16

func _physics_process(delta: float) -> void:
	$MovementScript.handle_movement(delta, alive)
	
	if alive:
		camera_controller.handle_camera(delta)
		$AnimationScript.handle_animation(delta)
			
func bounce() -> void:
	$MovementScript.bounce()

func die() -> void:
	alive = false
	set_collision_layer_value(1, false)
	SoundManager.play_player_die()
	$JumpReference.visible = false
	await $AnimationScript.play_death_animation()
	player.lose_life()
