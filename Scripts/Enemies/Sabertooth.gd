extends CharacterBody2D


var speed: float = -40.0
var current_speed: float = 0.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var facing_right: bool = false
var dead: bool = false

var max_health: int = 2
var health: int
var hit: bool = false
var can_attack: bool = true

func _ready():
	health = max_health
	$AnimationPlayer.play("Run")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if !$RayCast2D.is_colliding() && is_on_floor():
		flip()

	velocity.x = speed
	move_and_slide()

func flip():
	facing_right = !facing_right
	
	scale.x = abs(scale.x) * -1
	if facing_right:
		speed = abs(speed)
	else:
		speed = abs(speed) * -1

func _on_hitbox_area_entered(area):
	if area.get_parent() is Player && !dead && can_attack:
		area.get_parent().take_damage(1)

func take_damage(damage_amount: int):
	if !dead:
		$AnimationPlayer.play("Hit")
		health -= damage_amount
		get_node("Healthbar").update_healthbar(health, max_health)
		
		if health <= 0:
			die()

func get_hit():
	hit = !hit
	
	if hit:
		current_speed = speed
		speed = 0
		can_attack = false
	else:
		speed = current_speed
		can_attack = true
		$AnimationPlayer.play("Run")
		
func die():
	dead = true
	speed = 0
	$AnimationPlayer.play("Dead_Hit")
