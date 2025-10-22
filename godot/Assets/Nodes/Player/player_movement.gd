class_name PlayerMovement
extends Node3D

@export var player: CharacterBody3D
@export var player_raycast: RayCast3D
@export var camera: Camera3D
@export var body: Node3D
@export var jump_collision: Node3D

const SPEED = 10
var ANGLE_ADJUST = 90

func _ready() -> void:
	pass

func handle_movement(delta: float, playerIsAlive: bool) -> void:
	add_gravity(delta)
	
	if playerIsAlive:
		var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")
		move(delta, input_dir)
		rotate_body(delta, input_dir)
		incline_body()
	else:
		player.velocity.x = 0
		player.velocity.z = 0
	
	player.move_and_slide()
		
func add_gravity(delta: float):
	if not player.is_on_floor():
		player.velocity += player.get_gravity() * delta

func rotate_body(delta: float, input_dir: Vector2) -> void:
	#rotate character according to input pressed
	var character_is_moving := input_dir != Vector2(0, 0)
	if !character_is_moving:
		return

	#get angle where the character is running
	var velocity_angle : float = get_velocity_angle()
	#subtract velocity angle with player global rotation to get relative velocity of the player
	#instead of global velocity
	var relative_turn_angle = velocity_angle - player.global_rotation_degrees.y
	#keep resulting angle between -180 and 180 degress to avoid increasing values
	var wrap_turn_angle := wrapf(relative_turn_angle, -180, 180)
	body.rotation.y = lerp_angle(body.rotation.y, deg_to_rad(wrap_turn_angle), 0.5)
		
func get_velocity_angle() -> float:
	var player_velocity: Vector3 = player.velocity
	var horizontal_velocity: Vector2 = Vector2(-player_velocity.x, player_velocity.z)
	var angle_in_radians: float = horizontal_velocity.angle()

	#adjust angle orientation by 90 degrees
	var adjusted_velocity_angle = rad_to_deg(angle_in_radians) + ANGLE_ADJUST
	return adjusted_velocity_angle
		
func incline_body() -> void:
	#align character with irregular floor (raycast must be in top level)
	player_raycast.global_position = player.global_position
	
	if player.is_on_floor():
		var raycast_floor_inclination: Vector3 = player_raycast.get_collision_normal()
		align_character_with_floor_inclination(raycast_floor_inclination)
	else:
		align_character_with_floor_inclination(Vector3.UP)
		
func align_character_with_floor_inclination(inclination: Vector3):
		var newAlignment: Transform3D = player.global_transform
		newAlignment.basis.y = inclination
		newAlignment.basis.x = -newAlignment.basis.z.cross(inclination)
		newAlignment.basis = newAlignment.basis.orthonormalized()
		player.global_transform = player.global_transform.interpolate_with(newAlignment, 0.3)

func move(delta: float, input_direction: Vector2) -> void:
	#Get actual input direction considering camera position
	var direction: Vector3 = (camera.global_transform.basis * Vector3(input_direction.x, 0, input_direction.y))
	if direction:
		var strength = direction.length() * SPEED
		var direction_normalized = direction.normalized()
		player.velocity.x = lerp(player.velocity.x, direction_normalized.x * strength, 0.05)
		player.velocity.z = lerp(player.velocity.z, direction_normalized.z * strength, 0.05)
	else:
		#add inertia if player is jumping
		var weight := 0.2
		var jumping := !player.is_on_floor()
		if jumping:
			weight = 0.025
		
		#apply stopping movement
		player.velocity.x = lerp(player.velocity.x, move_toward(player.velocity.x, 0, SPEED), weight)
		player.velocity.z = lerp(player.velocity.z, move_toward(player.velocity.z, 0, SPEED), weight)
	
func bounce() -> void:
	player.velocity.y = player.JUMP_VELOCITY * 0.85
	
