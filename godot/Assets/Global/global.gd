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
	"res://Menu/story_1.tscn",
	"res://Levels/level_1.tscn",
	"res://Levels/level_2.tscn",
	"res://Levels/level_3.tscn",
	"res://Menu/story_2.tscn",
	"res://Levels/level_4.tscn",
	"res://Levels/level_5.tscn",
	"res://Levels/level_6.tscn",
	"res://Menu/story_3.tscn",
	"res://Levels/level_7.tscn",
	"res://Levels/level_8.tscn",
	"res://Levels/level_9.tscn",
	"res://Menu/story_4.tscn",
	"res://Levels/level_10.tscn",
	"res://Levels/level_11.tscn",
	"res://Levels/level_12.tscn",
	"res://Menu/story_5.tscn",
	"res://Levels/level_end.tscn",
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

func go_to_main_menu() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().change_scene_to_file("res://Menu/menu.tscn")
	
func go_to_next_level() -> void:
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
	
func is_game_fullscreen() -> bool:
	return DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN
	
#DEFAULT KEY MAPPING
var default_cam_left := InputMap.action_get_events("cam_left")
var default_cam_right := InputMap.action_get_events("cam_right")
var default_cam_adjust := InputMap.action_get_events("cam_adjust_key")
var default_move_up := InputMap.action_get_events("move_up")
var default_move_left := InputMap.action_get_events("move_left")
var default_move_right := InputMap.action_get_events("move_right")
var default_move_down := InputMap.action_get_events("move_down")
	
#INVERTED KEY MAPPING
var inverted_cam_left := InputMap.action_get_events("cam_left_inverted")
var inverted_cam_right := InputMap.action_get_events("cam_right_inverted")
var inverted_cam_adjust := InputMap.action_get_events("cam_adjust_inverted")
var inverted_move_up := InputMap.action_get_events("move_up_inverted")
var inverted_move_left := InputMap.action_get_events("move_left_inverted")
var inverted_move_right := InputMap.action_get_events("move_right_inverted")
var inverted_move_down := InputMap.action_get_events("move_down_inverted")

func toggle_fullscreen(value: bool) -> void:
	if value:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		
func is_key_map_inverted() -> bool:
	return InputMap.action_get_events("cam_left") == inverted_cam_left
	
func toggle_key_map_inversion(toggle: bool) -> void:
	erase_current_mapping()
	
	if toggle:
		print("inverted mapping")
		map_all_inputs("cam_left", inverted_cam_left)
		map_all_inputs("cam_right", inverted_cam_right)
		map_all_inputs("cam_adjust_key", inverted_cam_adjust)
		
		map_all_inputs("move_up", inverted_move_up)
		map_all_inputs("move_left", inverted_move_left)
		map_all_inputs("move_right", inverted_move_right)
		map_all_inputs("move_down", inverted_move_down)
		
	else:
		map_all_inputs("cam_left", default_cam_left)
		map_all_inputs("cam_right", default_cam_right)
		map_all_inputs("cam_adjust_key", default_cam_adjust)
		
		map_all_inputs("move_left", default_move_left)
		map_all_inputs("move_right", default_move_right)
		map_all_inputs("move_up", default_move_up)
		map_all_inputs("move_down", default_move_down)
		
func erase_current_mapping() -> void:
	action_erase_event("cam_left")
	action_erase_event("cam_right")
	action_erase_event("cam_adjust_key")
	
	action_erase_event("move_left")
	action_erase_event("move_right")
	action_erase_event("move_up")
	action_erase_event("move_down")
	
func action_erase_event(action: String) -> void:
	var events := InputMap.action_get_events(action)
	for event in events:
		InputMap.action_erase_event(action, event)

func map_all_inputs(action: String, events: Array[InputEvent]) -> void:
	for event in events:
		InputMap.action_add_event(action, event)
