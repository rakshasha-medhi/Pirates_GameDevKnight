extends Node

var level_dic = {
	"Level1": {
		"unlocked": true,
		"score": 0,
		"max_score": 0,
		"coins": 0,
		"max_coins": 0,
		"damage_taken": 0,
		"unlocks": "Level2",
		"beaten": false,
	},
#	"Level2": {
#		"unlocked": true,
#		"score": 0,
#		"max_score": 0,
#		"coins": 0,
#		"max_coins": 0,
#		"damage_taken": 0,
#		"unlocks": "Level3",
#		"beaten": false,
#	},
#	"Level3": {
#		"unlocked": true,
#		"score": 0,
#		"max_score": 0,
#		"coins": 0,
#		"max_coins": 0,
#		"damage_taken": 0,
#		"unlocks": "Level4",
#		"beaten": false,
#	}
}

#func _ready():
#	generate_level("Level2")
#	print(level_dic)

func generate_level(level):
	if level not in level_dic:
		level_dic[level] = {
			"unlocked": false,
			"score": 0,
			"max_score": 0,
			"coins": 0,
			"max_coins": 0,
			"damage_taken": 0,
			"unlocks": generate_level_number(level),
			"beaten": false,
		}

func generate_level_number(level = "Level2"):
	var level_number = ""
	for character in level:
		if character.is_valid_int():
			level_number += character
#			"" 			 +  "2" = "2"
#			level_number = "2"
	level_number = int(level_number) + 1
#	level_number = int("2") + 1
#	level_number = 2 + 1
#	level_number = 3
	
	return "Level" + str(level_number)
#			"Level" + str(3)
#			"Level" + "3"
#			"Level3"
func update_level(level: String, 
				score: int, 
				max_score: int, 
				coins: int, 
				max_coins: int, 
				damage_taken: int, 
				beaten: bool):
	
	level_dic[level]["score"] = score
	level_dic[level]["max_score"] = max_score
	level_dic[level]["coins"] = coins
	level_dic[level]["max_coins"] = max_coins
	level_dic[level]["damage_taken"] = damage_taken
	level_dic[level]["beaten"] = beaten
	print(level_dic)

