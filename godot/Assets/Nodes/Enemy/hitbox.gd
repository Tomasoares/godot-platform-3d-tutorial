extends Area3D

@export var projectile : Projectile

func _on_body_entered(body: Node3D) -> void:
	projectile.pop_up()
