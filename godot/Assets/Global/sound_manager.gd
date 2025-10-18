extends Control

func play_player_jump() -> void:
	$Sound/PlayerJump.play()

func play_coin_collect() -> void:
	$Sound/CoinCollect.play()

func play_player_die() -> void:
	$Sound/PlayerDie.play()

func play_kill_enemy() -> void:
	$Sound/SquishEnemy.play()

func play_extra_life_collect() -> void:
	$Sound/ExtraLifeCollect.play()
	
func play_box_kick_sound() -> void:
	$Sound/BoxKick.play()
	
func play_button_selected_sound() -> void:
	$Sound/ButtonSelected.play()
	
func play_button_go_back_sound() -> void:
	$Sound/ButtonGoBack.play()
	
func play_button_apply_sound() -> void:
	$Sound/ButtonApply.play()
	
func play_bump_sound() -> void:
	$Sound/BumpSound.play()
	
func play_bounce_sound() -> void:
	$Sound/BounceSound.play()
	
func play_level_cleared_music() -> void:
	$Sound/LevelCleared.play()
	
func play_main_menu_music() -> void:
	$Music/MainMenuMusic.play()
	
func stop_main_menu_music() -> void:
	$Music/MainMenuMusic.stop()
	
func play_game_over_music() -> void:
	$Music/GameOver.play()
	
func play_victory_song() -> void:
	$Music/Victory.play()
	
func play_level_ganymade() -> void:
	if !$Music/LevelGanymade.playing:
		$Music/LevelGanymade.play()
	
func play_level_underground() -> void:
	if !$Music/LevelUndergroundShelter.playing:
		$Music/LevelUndergroundShelter.play()

func play_level_outside() -> void:
	if !$Music/LevelOutside.playing:
		$Music/LevelOutside.play()

func play_level_inferno() -> void:
	if !$Music/Levelinferno.playing:
		$Music/Levelinferno.play()
		
func stop_level_ganymade() -> void:
	$Music/LevelGanymade.stop()

func stop_all_music() -> void:
	var music_nodes := get_tree().get_nodes_in_group("music")
	for node in music_nodes:
		if node is AudioStreamPlayer or node is AudioStreamPlayer2D or node is AudioStreamPlayer3D:
			node.stop()
