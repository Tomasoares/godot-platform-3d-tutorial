extends Control
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("RESET")
	$OptionsMenu.visible = false
	release_focus()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $OptionsMenu.visible:
		return
		
	if Input.is_action_just_pressed("pause"):
		if get_tree().paused:
			resume()
			SoundManager.play_button_go_back_sound()
		else:
			pause()
			
	if get_tree().paused and Input.is_action_just_pressed("go_back"):
		resume()
		SoundManager.play_button_go_back_sound()
		

func resume() -> void:
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")
	Input.flush_buffered_events()
	get_viewport().gui_release_focus()

func pause() -> void:
	get_tree().paused = true
	$AnimationPlayer.play("blur")
	$PauseMenu/ResumeButton.grab_focus()

func _on_resume_button_pressed() -> void:
	resume()

func _on_restart_button_pressed() -> void:
	resume()
	start_restart_process()
	
func start_restart_process() -> void:
	await get_tree().create_timer(0.3).timeout
	hide_pause_menu()
	$AnimationPlayer.play("restarting")
	await get_tree().create_timer(1.7).timeout
	get_tree().reload_current_scene()

func _on_exit_button_pressed() -> void:
	resume()
	Global.go_to_main_menu()


func _on_options_button_pressed() -> void:
	hide_pause_menu()
	$OptionsMenu.visible = true
	$OptionsMenu/VolumeSlider.grab_focus()


func _on_pause_menu_visibility_changed() -> void:
	$PauseMenu/ResumeButton.grab_focus()

func hide_pause_menu() -> void:
	$PauseMenu.visible = false


func _on_fullscreen_check_button_toggled(toggled_on: bool) -> void:
	Global.toggle_fullscreen(toggled_on)
