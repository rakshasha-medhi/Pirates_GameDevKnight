extends Node2D

func _ready():
	$AnimationPlayer.play("Idle")

func _on_area_2d_area_entered(_area):
	GameManager.gain_coins(1)
	queue_free()
