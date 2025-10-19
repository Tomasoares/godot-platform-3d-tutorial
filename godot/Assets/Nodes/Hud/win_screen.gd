class_name WinScreen
extends Control

@export var duration := 0.5
@export var pause_manager : Control
@export var timer_manager : TimerManager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	modulate.a = 0.0

func win() -> void:
	SoundManager.play_level_cleared_music()
	pause_manager.process_mode = Node.PROCESS_MODE_DISABLED
	$NextButton.grab_focus()
	update_timer(timer_manager.minutes, timer_manager.seconds)
	get_tree().paused = true
	show_win_screen()

func show_win_screen() -> void:
	var tween := create_tween()
	tween.tween_property(self, "modulate:a", 1.0, duration)
	
func update_timer(minutes: float, seconds: float):
	$TimeLabel/MinuteLabel.text = "%02d" % minutes
	$TimeLabel/SecondLabel.text = "%02d" % seconds
	
func _on_next_button_pressed() -> void:
	Global.go_to_next_level()
