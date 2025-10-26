extends CharacterBody2D

@export var speed: float = 30
@export var chase_speed: float = 90
@export var gravity: float = 400

var direction: int = -1
var state: String = "patrol"
var player: Node = null
var is_dead: bool = false

@onready var animated_sprite = $AnimatedSprite2D
@onready var kill_zone = $Killzone
@onready var stomp_zone = $StompZone
@onready var detection_zone = $DetectionZone

func _ready():
	kill_zone.body_entered.connect(_on_killzone_body_entered)
	stomp_zone.body_entered.connect(_on_stompzone_body_entered)
	detection_zone.body_entered.connect(_on_detection_entered)
	detection_zone.body_exited.connect(_on_detection_exited)
	
	animated_sprite.play("walk")

func _physics_process(delta):
	if is_dead:
		return

	var target_speed = speed
	if state == "chase" and player:
		target_speed = chase_speed
		direction = sign(player.global_position.x - global_position.x)

	# Smoothly accelerate toward target speed
	velocity.x = lerp(velocity.x, direction * target_speed, 5 * delta)

	# Flip sprite based on direction
	animated_sprite.flip_h = direction > 0

	# Gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	move_and_slide()

	# Reverse direction if hitting a wall
	if is_on_wall():
		direction *= -1


# --- Kill player if touched from side or bottom ---
func _on_killzone_body_entered(body):
	if body.name == "Player" and not is_dead:
		body.die()


# --- Player stomps slime ---
func _on_stompzone_body_entered(body):
	if body.name == "Player" and not is_dead:
		if body.global_position.y < global_position.y - 4:
			call_deferred("die")  # <— deferred call avoids blocking issue
			body.bounce()


# --- Player enters detection area ---
func _on_detection_entered(body):
	if body.name == "Player" and not is_dead:
		state = "chase"
		player = body
		animated_sprite.play("chase")
		direction = sign(player.global_position.x - global_position.x)
		animated_sprite.flip_h = direction > 0


# --- Player exits detection ---
func _on_detection_exited(body):
	if body == player and not is_dead:
		state = "patrol"
		player = null
		animated_sprite.play("walk")


# --- Death sequence ---
func die():
	is_dead = true
	state = "dead"
	velocity = Vector2.ZERO
	stomp_zone.set_deferred("monitoring", false)
	kill_zone.set_deferred("monitoring", false)
	detection_zone.set_deferred("monitoring", false)
	animated_sprite.play("death")
	await get_tree().create_timer(0.4).timeout
	queue_free()
