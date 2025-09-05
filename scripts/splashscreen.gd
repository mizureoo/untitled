extends Control

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var overlay: ColorRect = $ColorRect
@onready var animation_player: AnimationPlayer = $Sprite2D/AnimationPlayer

# Preload the main menu scene
var main_menu_scene = preload("res://scenes/main_menu.tscn").instantiate()

func _ready():
	# Add the main menu as a child, behind the overlay and logo
	add_child(main_menu_scene)
	main_menu_scene.z_index = -1  # make sure it's behind
	main_menu_scene.visible = false  # hide it initially

	# Play splash animation
	animation_player.play("fade_out")
	animation_player.animation_finished.connect(_on_animation_finished)

func _on_animation_finished(anim_name):
	# Show the main menu under the overlay
	main_menu_scene.visible = true

	# Fade out logo and overlay
	var tween = get_tree().create_tween()
	tween.tween_property(sprite_2d, "modulate:a", 0, 1.5)
	tween.tween_property(overlay, "modulate:a", 0, 1.5)

	# Remove splash nodes after fade completes
	tween.finished.connect(func():
		sprite_2d.queue_free()
		overlay.queue_free()
	)
