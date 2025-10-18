class_name EnemyAttackArea
extends Area3D

@export var enemy : CharacterBody3D

func _on_body_entered(body: Node3D) -> void:
	enemy.interrupt_behaviours()
	body.die()
