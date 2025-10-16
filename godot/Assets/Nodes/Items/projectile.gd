class_name Projectile
extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_time_to_live_timer_timeout() -> void:
	await disappear()
	queue_free()

func disappear() -> Signal:
	$AnimationPlayer.play("disappear")
	return $AnimationPlayer.animation_finished
