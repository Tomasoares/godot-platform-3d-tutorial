extends Node

@export var animation_player: AnimationPlayer
@export var sound : AudioStreamPlayer3D
@export var enemy_shooter : EnemyShooter
@export var bullet_spawn_shoot : Node3D

const PROJECTILE_SCENE = preload("res://Assets/Nodes/Enemy/projectile.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_shooting_timer_timeout() -> void:
	animation_player.play("shoot")
	sound.play()
	create_projectile()
	
func create_projectile() -> void:
	var projectile : Projectile = PROJECTILE_SCENE.instantiate()
	var source_position := bullet_spawn_shoot.global_position
	var target_position := enemy_shooter.get_player().get_marker_global_position()
	projectile.start_motion(source_position, target_position)
	get_tree().root.add_child(projectile)
