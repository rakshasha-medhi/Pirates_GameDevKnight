extends Control

@onready var fill_max = $ColorRect.size.x
var fill_amount: float

func update_healthbar(health: int, max_health: int):
	fill_amount = (float(health) / max_health) * fill_max
	$ColorRect.size.x = fill_amount
	
