class_name SpikeBall
extends AnimatableBody3D

var initialPosition : Vector3
@export var finalPosition : Vector3
@export var duration : float = 1.0
@export var pause : float = 0.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initialPosition = position
	move()
	
func move() -> void:
	var tween := create_tween()
	tween.tween_property(self, "position", finalPosition, duration).set_trans(Tween.TRANS_SINE).set_delay(pause)
	tween.tween_property(self, "position", initialPosition, duration).set_trans(Tween.TRANS_SINE).set_delay(pause)
	tween.set_loops()
