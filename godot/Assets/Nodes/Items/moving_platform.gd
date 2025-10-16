extends AnimatableBody3D

var initial_position : Vector3
@export var finalPosition : Vector3
@export var duration : float = 5.0
@export var pause : float = 0.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initial_position = position
	move()
	
func move() -> void:
	var tween := create_tween()
	tween.tween_property(self, "position", finalPosition, duration).set_trans(Tween.TRANS_SINE).set_delay(pause)
	tween.tween_property(self, "position", initial_position, duration).set_trans(Tween.TRANS_SINE).set_delay(pause)
	tween.set_loops()
