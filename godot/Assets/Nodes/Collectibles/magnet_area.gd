class_name CoinMagnetArea
extends Area3D

@export var coin : Area3D

var magnet := false
var target : Node3D = null
var exponential_weight := 0.02

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !magnet:
		return
		
	exponential_weight += 0.012
	coin.global_position = lerp(coin.global_position, target.global_position, exponential_weight)
	
	if coin.get_overlapping_bodies().has(target):
		magnet = false
	
	
func _on_body_entered(body: Node3D) -> void:
	magnet = true
	target = body
