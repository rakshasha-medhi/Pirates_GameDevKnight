extends Node2D
class_name Waterlevel

@export var waterpoint = false

var activated = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func activate():
	GameManager.waterpoint = self
	activated = true
	gravity = 30

func _on_area_2d_area_entered(area):
	if area.get_parent() is Player && !activated:
		activate()
