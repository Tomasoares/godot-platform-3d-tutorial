class_name EnemyMovement
extends Node

@export var enemy : CharacterBody3D
@export var raycast : RayCast3D
@export var speed := 3.0
@export var turning_delay = 0.6

var current_direction := Vector3(1, 0, 0)
var turning := false
var stop := false

func updateCurrentDirection(newValue: Vector3) -> void:
	current_direction = newValue
	
func stand_still() -> void:
	stop = true

func handle_movement(delta: float) -> void:
	if turning:
		return
		
	move(delta)
	turn(delta)
	
func move(delta: float)	-> void:
	if stop:
		return 
	# Add the gravity.
	if not enemy.is_on_floor():
		enemy.velocity += enemy.get_gravity() * delta
		
	enemy.velocity.x = current_direction.x * speed
	enemy.velocity.z = current_direction.z * speed
	enemy.move_and_slide()	
	
func turn(delta : float) -> void:	
	if enemy.is_on_wall():
		perform_turn(delta)
	elif not raycast.is_colliding() and enemy.is_on_floor():
		perform_turn(delta)

func perform_turn(delta : float) -> void:
	turning = true
	var oldDirection := current_direction
	current_direction = Vector3.ZERO 
	
	#Create turning animation
	(
		create_tween()
			.tween_property(enemy, "rotation_degrees", Vector3(0,180,0),turning_delay)
			.as_relative()
	)
	
	#Adds timer before turning around
	await get_tree().create_timer(turning_delay).timeout
	current_direction.x = oldDirection.x * -1
	current_direction.z = oldDirection.z * -1
	move(delta)
	turning = false
