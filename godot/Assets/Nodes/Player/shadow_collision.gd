extends Area3D

@export var shadow_render : MeshInstance3D


func _on_body_entered(body: Node3D) -> void:
	shadow_render.visible = true


func _on_body_exited(body: Node3D) -> void:
	shadow_render.visible = false
