class_name EnemyVulnerableArea
extends Area3D

@export var enemy : CharacterBody3D
@export var animation_script : EnemyAnimation

func _on_area_entered(area: Area3D) -> void:
	#disable hitboxes
	SoundManager.play_kill_enemy()
	enemy.interrupt_behaviours()
	await animation_script.play_death_animation()
	enemy.queue_free()
