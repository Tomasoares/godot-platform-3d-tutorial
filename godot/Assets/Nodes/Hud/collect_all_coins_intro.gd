extends Control

@export var duration := 2.0
@export var level_number := "x2"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !Global.show_intro_text:
		$Title.visible = false
		$LevelTitle.visible = false
		return
		
	$LevelTitle.text = "Level " + level_number
	Global.show_intro_text = false
	animate_title()
	animate_level_title()
	
func animate_title():
	var tween := create_tween()
	tween.tween_property($Title, "modulate:a", 0.0, duration)
	tween.tween_property($Title, "outline_modulate:a", 0.0, duration)
	
func animate_level_title():
	var tween := create_tween()
	tween.tween_property($LevelTitle, "modulate:a", 0.0, duration)
	tween.tween_property($LevelTitle, "outline_modulate:a", 0.0, duration)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
