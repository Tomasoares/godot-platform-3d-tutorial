class_name CoinManager
extends Node3D

var coins := 0
var available_coins: int

const COIN_GROUP = "coin"

@export_file var finish_scene
@export var hud_manager : HudManager
@export var win_screen : WinScreen

func _ready() -> void:
	available_coins = get_tree().get_node_count_in_group(COIN_GROUP)
	hud_manager.update_initial_coin_values(available_coins)
		
func handle_coin_collect():
	increment_coin_counter()
	hud_manager.update_coin_count(coins)
	check_win_condition()
	
func increment_coin_counter():
	coins += 1

func check_win_condition():
	if coins >= available_coins:
		win_screen.win()
