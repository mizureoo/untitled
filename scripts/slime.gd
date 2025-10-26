extends CharacterBody2D

@export var speed: float = 40
@export var chase_speed: float = 70
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

	match state:
		"patrol":
			velocity.x = direction * speed
		"chase":
			if player:
				direction = sign(player.global_position.x - global_position.x)
				velocity.x = direction * chase_speed
	
	# Flip sprite based on direction
	animated_sprite.flip_h = direction > 0
	
	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	
	move_and_slide()

	# Reverse direction if hitting a wall
	if is_on_wall():
		direction *= -1


# --- Kill player when touching side or bottom ---
func _on_killzone_body_entered(body):
	if body.name == "Player" and not is_dead:
		body.die()


# --- Player stomp kill ---
func _on_stompzone_body_entered(body):
	if body.name == "Player" and not is_dead:
		if body.global_position.y < global_position.y - 4:
			die()
			body.bounce()


# --- Player enters chase detection ---
func _on_detection_entered(body):
	if body.name == "Player":
		state = "chase"
		player = body


# --- Player leaves detection area ---
func _on_detection_exited(body):
	if body == player:
		state = "patrol"
		player = null


# --- Slime death ---
func die():
	is_dead = true
	state = "dead"
	velocity = Vector2.ZERO
	stomp_zone.monitoring = false
	kill_zone.monitoring = false
	detection_zone.monitoring = false
	animated_sprite.play("death")
	await get_tree().create_timer(0.4).timeout
	queue_free()
