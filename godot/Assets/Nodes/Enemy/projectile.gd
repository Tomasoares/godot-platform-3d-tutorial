class_name Projectile
extends Node3D

var speed: float = 10.0
var direction: Vector3 = Vector3.ZERO

const TOO_CLOSE = 4.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("RESET")
	$TimeToLiveTimer.start(0.0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += direction * speed * delta

func _on_time_to_live_timer_timeout() -> void:
	await disappear()
	queue_free()

func disappear() -> Signal:
	$AnimationPlayer.play("disappear")
	return $AnimationPlayer.animation_finished
	
func start_motion(source_position: Vector3, target_position: Vector3):
	global_position = source_position
	var direction_vector = target_position - source_position
	if direction_vector.length() < TOO_CLOSE:
		direction_vector.y = 0
	else:
		direction_vector.y = clampf(direction_vector.y, -3, 3)
	
	direction = direction_vector.normalized()
	
func pop_up():
	queue_free()
