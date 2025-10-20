extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label.modulate.a = 0.0
	$Label.outline_modulate.a = 0.0

func _on_talking_area_body_entered(body: Node3D) -> void:
	$AnimationPlayer.play("wave-3")
	show_text()
	$TalkingArea.set_collision_mask_value(Global.Layers.PLAYER, 0)

func show_text() -> void:
	fade_in_label(0.1)
	await get_tree().create_timer(7.0).timeout
	fade_out_label(0.1)

func fade_in_label(duration: float) -> void:
	var tween := get_tree().create_tween()
	tween.tween_property($Label, "modulate:a", 1.0, duration)
	tween.tween_property($Label, "outline_modulate:a", 1.0, duration)
	
func fade_out_label(duration: float) -> void:
	var tween := get_tree().create_tween()
	tween.tween_property($Label, "modulate:a", 0.0, duration)
	tween.tween_property($Label, "outline_modulate:a", 0.0, duration)
