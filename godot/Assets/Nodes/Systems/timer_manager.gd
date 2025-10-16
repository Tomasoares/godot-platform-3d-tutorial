class_name TimerManager
extends Node3D

@export var hud : HudManager

var time := 0.0
var seconds := 0.0
var minutes := 0.0

func _process(delta: float) -> void:
	time += delta
	seconds = fmod(time, 60)
	minutes = fmod(time, 3600) / 60
	hud.update_timer(minutes, seconds)
