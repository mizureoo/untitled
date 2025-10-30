extends CharacterBody2D
class_name PlayerController

const SPEED = 200.0
const JUMP_VELOCITY = -250.0
const GRAVITY = 800.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
var is_dead: bool = false

func _physics_process(delta: float) -> void:
	if is_dead:
		return  # Stop movement if dead

	# --- Gravity ---
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# --- Jump ---
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# --- Horizontal movement ---
	var direction := Input.get_axis("move_left", "move_right")
	velocity.x = direction * SPEED

	# --- Sprite flip ---
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true

	# --- Animations ---
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")

	move_and_slide()

# --- Called by enemy KillZone ---
func die():
	if is_dead:
		return
	is_dead = true
	GameManager.lose_life()

	animated_sprite.play("death")  # Ensure “death” animation exists

	if $DeathSound and $DeathSound.stream:
		$DeathSound.play()

	# Fade-out tween
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 0.8)

	set_process(false)
	set_physics_process(false)

# --- Called by enemy StompZone when jumping on enemy ---
func bounce():
	velocity.y = JUMP_VELOCITY / 1
