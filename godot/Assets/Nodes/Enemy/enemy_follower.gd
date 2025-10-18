class_name EnemyFollower
extends CharacterBody3D

@export var player : Player
@export var follow_area : Area3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	configure_follow_area()
	
func configure_follow_area() -> void:
	var area := follow_area
	if area == null:
		area = $FollowMechanic/ActionAreaDefault
	$FollowMechanic.configure_follow_area(area)

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$AnimationScript.handle_animation(delta)
	add_gravity(delta)
	move_and_slide()
	
func add_gravity(delta: float):
	if not is_on_floor():
		velocity.y += get_gravity().y * delta
		
func interrupt_behaviours() -> void:
	set_collision_layer_value(Global.Layers.ENEMY, false)
	$AttackArea.set_collision_layer_value(Global.Layers.ENEMY, false)
	$AttackArea.set_collision_layer_value(Global.Layers.ENEMY_WEAKNESS, false)
	$AttackArea.set_collision_mask_value(Global.Layers.PLAYER, false)
	$VulnerableArea.set_collision_layer_value(Global.Layers.ENEMY_WEAKNESS, false)
	$VulnerableArea.set_collision_mask_value(Global.Layers.PLAYER_ATTACK, false)
	$FollowMechanic.stop()

func get_player() -> Player:
	return player
	
func bounce() -> void:
	velocity.y += 7
