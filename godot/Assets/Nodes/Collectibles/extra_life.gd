class_name ExtraLife
extends Node3D

@export var lives_manager : LivesManager

func _ready() -> void:
	if Global.is_life_already_picked_up(get_name()):
		queue_free()
		return
		
	$Label.modulate.a = 0.0
	$Label.outline_modulate.a = 0.0

func _on_pickup_area_3d_2_body_entered(body: Node3D) -> void:
	SoundManager.play_extra_life_collect()
	$ExtraLifeIcon.queue_free()
	lives_manager.add_extra_try()
	show_extra_life_icon()
	Global.add_life_to_picked_up_set(get_name())
	pass # Replace with function body.

func show_extra_life_icon() -> void:
	fade_in_label(0.1)
	await get_tree().create_timer(1.0).timeout
	fade_out_label(0.05)
	await get_tree().create_timer(1.0).timeout
	queue_free()

func fade_in_label(duration: float) -> void:
	var tween := get_tree().create_tween()
	tween.tween_property($Label, "modulate:a", 1.0, duration)
	tween.tween_property($Label, "outline_modulate:a", 1.0, duration)
	
func fade_out_label(duration: float) -> void:
	var tween := get_tree().create_tween()
	tween.tween_property($Label, "modulate:a", 0.0, duration)
	tween.tween_property($Label, "outline_modulate:a", 0.0, duration)
