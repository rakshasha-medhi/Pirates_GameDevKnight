extends Node

signal gained_coins(int)

var coins: int
var current_checkpoint: Checkpoint
var pause_menu
var waterpoint: Waterlevel
var player: Player
var paused: bool = false

func respawn_player():
	player.health = player.max_health
	if current_checkpoint != null:
		player.position = current_checkpoint.global_position

func gain_coins(coins_gained: int):
	coins += coins_gained
	emit_signal("gained_coins", coins_gained)
	print(coins)

func pause_play():
	paused = !paused
	pause_menu.visible = paused

func resume():
	pause_play()

func restart():
	coins = 0
	current_checkpoint = null
	get_tree().reload_current_scene()

func load_world():
	pass
	
func quit():
	get_tree().quit()

func drowning():
	if waterpoint != null:
		player.gravity = 30
