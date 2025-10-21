extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SoundManager.stop_all_music()
	$AnimationPlayer.play("typing")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $AnimationPlayer.is_playing():
		SoundManager.play_typing_sound()
		
	if skip_pressed():
		if $AnimationPlayer.is_playing():
			$AnimationPlayer.speed_scale = 20.0
		else:
			Global.go_to_next_level()
		
func skip_pressed() -> bool:
	if Input.is_action_just_pressed("jump"):
		return true
		
	if Input.is_action_just_pressed("ui_cancel"):
		return true
		
	if Input.is_action_just_pressed("pause"):
		return true
	
	return false
