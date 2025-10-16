extends Control

@export var duration := 2.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !Global.show_intro_text:
		$Title.visible = false
		return
		
	Global.show_intro_text = false
	var tween := create_tween()
	tween.tween_property($Title, "modulate:a", 0.0, duration)
	tween.tween_property($Title, "outline_modulate:a", 0.0, duration)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
