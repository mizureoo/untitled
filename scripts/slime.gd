extends Node2D

const SPEED = 60
var direction = 1

@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	animated_sprite.play("walk")  # Start walking immediately

func _process(delta: float) -> void:
	# Flip direction when hitting wall/raycast detects obstacle
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite.flip_h = false
	elif ray_cast_left.is_colliding():
		direction = 1
		animated_sprite.flip_h = true

	# Move slime
	position.x += direction * SPEED * delta

	# Always ensure walking animation is playing
	if animated_sprite.animation != "walk":
		animated_sprite.play("walk")
