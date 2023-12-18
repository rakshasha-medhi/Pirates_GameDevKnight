extends Node
class_name RunTimeLevel

@onready var level_name = name

var max_score = 0
var max_coins = 0

func _ready():
	GameManager.level_beaten.connect(beat_level)
	set_values()

#func set_values():
#	for node in get_children():
#		if node is Coin:
#			max_score += node.score
#			max_coins += node.coins
#
#		if node is Sabertooth or node is Cannon:
#			max_score += node.score

func set_values():
#	var coin_holder = get_node("CoinHolder")
#	var CH_children = coin_holder.get_children()
	var coin_holder_children = get_node("CoinHolder").get_children()
	for node in coin_holder_children:
		if node is Coin:
			max_score += node.score
			max_coins += node.coins
	
	var saberteeth_children = get_node("Saberteeth").get_children()
	for node in saberteeth_children:
		if node is Sabertooth:
			max_score += node.score
	
	var cannons_children = get_node("Cannons").get_children()
	for node in cannons_children:
		if node is Cannon:
			max_score += node.score

func beat_level():
	LevelData.generate_level(LevelData.level_dic[level_name]["unlocks"])
	LevelData.level_dic[LevelData.level_dic[level_name]["unlocks"]]["unlocked"] = true
	
	LevelData.update_level(level_name, 
						GameManager.score, 
						max_score, 
						GameManager.coins, 
						max_coins, 
						GameManager.damage_taken, 
						true)



