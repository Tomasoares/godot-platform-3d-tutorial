class_name EnemyShooter
extends CharacterBody3D

@export var player : Player
@export var shooting_area : Area3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	configure_shooting_area()
	
func configure_shooting_area() -> void:
	var shooting_area_in_use := shooting_area
	if shooting_area_in_use == null:
		shooting_area_in_use = $ShootMechanic/ShootingAreaDefault
	$ShootMechanic.configure_shooting_area(shooting_area_in_use)

	
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
	$VulnerableArea.set_collision_layer_value(Global.Layers.ENEMY_WEAKNESS, false)
	$VulnerableArea.set_collision_mask_value(Global.Layers.PLAYER_ATTACK, false)
	$ShootMechanic.stop()

func get_player() -> Player:
	return player
	
func bounce() -> void:
	velocity.y += 10
