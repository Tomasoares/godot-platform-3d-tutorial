class_name ShootMechanic
extends Node

@export var enemy : EnemyShooter

func configure_shooting_area(shooting_area: Area3D) -> void:
	shooting_area.set_collision_layer_value(Global.Layers.PLAYER, 0)
	shooting_area.set_collision_mask_value(Global.Layers.PLAYER, 1)
	shooting_area.body_entered.connect(start_shooting)
	shooting_area.body_exited.connect(stop_shooting)

func start_shooting(body: Node) -> void:
	enemy.bounce()
	$AlertSound.play()
	
	if !body is PlayerCharacter:
		return
	$ShootingTimer.start(0.0)
	
func stop_shooting(body: Node) -> void:
	if !body is PlayerCharacter:
		return
	stop()
		
func stop() -> void:
	$ShootingTimer.stop()
