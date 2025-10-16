class_name HudManager
extends Node

@export var current_coin_label : Label
@export var all_coins : Label
@export var lives : Label
@export var timer_minutes : Label
@export var timer_seconds : Label

var expanded_coin_text := false
func update_initial_coin_values(total_coin: int):
	all_coins.text = str(total_coin)

func update_lives(lives_amount: int):
	lives.text = str(lives_amount)
	
func update_coin_count(amount: int):
	current_coin_label.text = str(amount) + "/"
	
	if amount >= 10 and not expanded_coin_text:
		expanded_coin_text = true
		all_coins.position.x += 20
		
func update_timer(minutes: float, seconds: float):
	timer_minutes.text = "%02d" % minutes
	timer_seconds.text = "%02d" % seconds
	
