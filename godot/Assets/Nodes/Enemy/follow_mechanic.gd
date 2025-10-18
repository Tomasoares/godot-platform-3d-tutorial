class_name FollowMechanic
extends Node

@export var enemy : EnemyFollower
@export var armature : Node3D
@export var speed: float = 5.0

var follow = false

func configure_follow_area(area: Area3D) -> void:
	area.set_collision_layer_value(Global.Layers.PLAYER, 0)
	area.set_collision_mask_value(Global.Layers.PLAYER, 1)
	area.body_entered.connect(start_following)
	area.body_exited.connect(stop_following)

func start_following(body: Node) -> void:
	enemy.bounce()
	$AlertSound.play()
	
	if !body is PlayerCharacter:
		return
	follow = true
	
func stop_following(body: Node) -> void:
	if !body is PlayerCharacter:
		return
	stop()
	
func stop() -> void:
	follow = false
	enemy.velocity = Vector3.ZERO
	
func _process(delta: float) -> void:
	follow_player(delta)

func follow_player(delta: float) -> void:
	if !follow:
		return
	
	if distance_from_player() < 2.0:
		enemy.velocity = lerp (enemy.velocity, Vector3.ZERO, 0.01)
		return
		
	var forward_direction := armature.global_transform.basis.z.normalized()
	forward_direction.y = enemy.velocity.y / speed
	enemy.velocity = forward_direction * speed
	
func distance_from_player() -> float:
	var player := enemy.get_player().get_character()
	var distance_from_player := player.global_position.distance_to(enemy.global_position)
	return distance_from_player
