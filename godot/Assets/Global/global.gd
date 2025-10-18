extends Node


enum Layers {
	PLAYER = 1,
	GROUND = 2,
	ITEM = 3,
	ENEMY = 4,
	FALLZONE = 5,
	ENEMY_WEAKNESS = 6,
	PLAYER_ATTACK = 7
}

###### GLOBAL LIVES

var current_lives := 0
var reset_lives := true
var picked_lives := Dictionary()
var show_intro_text := true

func init_lives(tries_amount: int) -> void:
	if Global.reset_lives:
		Global.current_lives = tries_amount
		Global.reset_lives = false
		
func add_life_to_picked_up_set(lifeName : String) -> void:
	picked_lives.set(lifeName, 1)

func is_life_already_picked_up(lifeName : String) -> bool:
	return picked_lives.get(lifeName) == 1
	
###### GLOBAL SCENE MANAGEMENT
	
var initial_scene_order := [
	"res://Levels/level_1.tscn",
	"res://Levels/level_2.tscn",
	"res://Levels/level_3.tscn",
	"res://Levels/level_4.tscn",
	"res://Levels/level_5.tscn",
	"res://Levels/level_6.tscn",
]

var current_scene_order := []

func begin_level() -> void:
	picked_lives.clear()
	show_intro_text = true
	
func begin_game() -> void:
	current_scene_order = initial_scene_order.duplicate(true)
	init_lives(5)
	go_to_next_level()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func go_to_main_menu(stop_music = true) -> void:
	if stop_music:
		SoundManager.stop_all_music()
		
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().change_scene_to_file("res://Menu/menu.tscn")
	
func go_to_next_level(stop_music = true) -> void:
	if stop_music:
		SoundManager.stop_all_music()
	
	get_tree().paused = false
	begin_level()
	
	var scene : Variant = current_scene_order.pop_front()
	if scene != null:
		get_tree().change_scene_to_file(scene)
	else:
		get_tree().change_scene_to_file("res://Menu/thanksforplaying.tscn")
		
func game_over() -> void:
	SoundManager.stop_all_music()
	get_tree().change_scene_to_file("res://Menu/gameover.tscn")

###### GLOBAL CONTROL CONFIGURATION

var camera_sensitivity := 1000.0
const SENSITIVITY_MULTIPLIER := 200
const SENSITIVITY_JOYPAD_MULTIPLIER := 500
var invert_x := false
var invert_y := false
const VOLUME_MULTIPLIER := 7
	
func get_current_sensitivity() -> float:
	return camera_sensitivity / SENSITIVITY_MULTIPLIER
	
func set_current_sensitivity(value: float) -> void:
	camera_sensitivity = value * SENSITIVITY_MULTIPLIER
	
func get_final_camera_sensitivity_for_joypad_x(input_y: float) -> float:
	var sensitivity = camera_sensitivity / SENSITIVITY_JOYPAD_MULTIPLIER
	var invert := 1
	if !invert_y:
		invert = -1
	return deg_to_rad(input_y * sensitivity) * invert
	
func get_final_camera_sensitivity_for_joypad_y(input_x: float) -> float:
	var sensitivity = camera_sensitivity / SENSITIVITY_JOYPAD_MULTIPLIER
	var invert := 1
	if !invert_x:
		invert = -1
	return deg_to_rad(input_x * sensitivity) * invert
	
func get_final_camera_sensitivity_for_mouse_x() -> float:
	var sensitivity = (1000 - camera_sensitivity) + 2000
	if invert_x:
		sensitivity *= -1
	return sensitivity
	
func get_final_camera_sensitivity_for_mouse_y() -> float:
	var sensitivity = (1000 - camera_sensitivity) + 2000
	if invert_y:
		sensitivity *= -1
	return sensitivity
	
func get_game_volume() -> float:
	var master_bus_index := AudioServer.get_bus_index("Master")
	var volume := db_to_linear(AudioServer.get_bus_volume_db(master_bus_index))
	return volume * VOLUME_MULTIPLIER
	
func set_game_volume(value: float) -> void:
	var master_bus_index := AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_db(master_bus_index, linear_to_db(value / VOLUME_MULTIPLIER))
