extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var overlay: ColorRect = $ColorRect
@onready var main_menu_scene = preload("res://scenes/main_menu.tscn").instantiate()

func _ready():
	# Load main menu behind overlay
	add_child(main_menu_scene)
	main_menu_scene.z_index = -1
	main_menu_scene.visible = false

	# Play the AnimationPlayer sequence for logos
	animation_player.play("splash_fade")
	animation_player.animation_finished.connect(_on_logos_finished)

func _on_logos_finished(anim_name):
	# Show main menu under overlay
	main_menu_scene.visible = true

	# Tween overlay to fade out smoothly
	var tween = get_tree().create_tween()
	tween.tween_property(overlay, "modulate:a", 0, 1.5)  # fade overlay from 1 → 0
	tween.finished.connect(_finish_splash)

func _finish_splash():
	# Remove splash nodes
	$GodotLogo.queue_free()
	$MadeWithGodot.queue_free()
	$Logo.queue_free()
	overlay.queue_free()
