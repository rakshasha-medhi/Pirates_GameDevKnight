extends CharacterBody2D
class_name Player

@onready var animation = $AnimationPlayer
@onready var sprite = $Sprite2D
@onready var water_level = $"../WaterLevel"


@export var speed := 100.0
@export var jump_height := -300.0
@export var attacking = false

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var max_health = 2
var health = 0
var can_take_damage = true


func _ready():
	health = max_health
	GameManager.player = self

func _process(delta):
	if Input.is_action_just_pressed("attack"):
		attack()

func _physics_process(delta):
	if Input.is_action_just_pressed("left"):
		sprite.scale.x = abs(sprite.scale.x) * -1
		$AttackArea.scale.x = abs($AttackArea.scale.x) * -1
	if Input.is_action_just_pressed("right"):
		sprite.scale.x = abs(sprite.scale.x) * 1
		$AttackArea.scale.x = abs($AttackArea.scale.x) * 1
	
	# Add the gravity.
	if not is_on_floor():
#		animation.play("Fall")
		velocity.y += gravity * delta
	
	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
#		animation.play("Jump")
		velocity.y = jump_height
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice,you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
#		animation.play("Run")
		velocity.x = direction * speed
	else:
#		animation.play("Idle")
		velocity.x = move_toward(velocity.x, 0, speed)
	
	update_animation()
	move_and_slide()
	
#	if position.y >= 300:
#		drown()
	
	if position.y >= 600:
		die()

func attack():
	var overlapping_objects = $AttackArea.get_overlapping_areas()
#	for area in overlapping_objects:
#		var parent = area.get_parent()
#		parent.queue_free()
	
	for area in overlapping_objects:
		if area.get_parent().is_in_group("Enemies"):
			area.get_parent().die()
	
	attacking = true
	animation.play("Attack")

func update_animation():
	if !attacking:
		if velocity.x != 0:
			animation.play("Run")
		else:
			animation.play("Idle")
		if velocity.y < 0:
			animation.play("Jump")
		if velocity.y > 0:
			animation.play("Fall")

func drown():
#	gravity = 30	# introduces the gravity bug
	GameManager.drowning()

func take_damage(damage_amount: int):
	if can_take_damage:
		iframes()
		health -= damage_amount
		
		if health <= 0:
			die()

func iframes():
	can_take_damage = false
	await get_tree().create_timer(1).timeout
	can_take_damage = true

func die():
	# add die animation
	gravity = 980
	GameManager.respawn_player()
