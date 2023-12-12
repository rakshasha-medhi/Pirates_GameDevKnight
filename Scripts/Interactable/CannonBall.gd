extends Node2D

var direction
var speed: float = 200.0
var lifetime: float = randf_range(0.75, 1.5)
var hit: bool = false

func _ready():
	await get_tree().create_timer(lifetime).timeout
	die()

func _physics_process(delta):
	position.x += abs(speed * delta) * direction

func die():
	hit = true
	speed = 0
	$AnimationPlayer.play("Hit")
	

func _on_area_2d_area_entered(area):
	if area.get_parent() is Player && !hit:
		area.get_parent().take_damage(1)
		die()
