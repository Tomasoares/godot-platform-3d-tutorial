class_name EnemyShooter
extends Node3D

@export var player : Node3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$AnimationScript.handle_animation(delta)
	
func interrupt_behaviours() -> void:
	$VulnerableArea.set_collision_layer_value(Global.Layers.ENEMY_WEAKNESS, false)
	$VulnerableArea.set_collision_mask_value(Global.Layers.PLAYER_ATTACK, false)

func get_player() -> Node3D:
	return player
