extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var overlay: ColorRect = $ColorRect
var main_menu_scene: Control = null

func _ready():
	# Play the AnimationPlayer sequence for logos
	animation_player.play("fade_out")
	animation_player.animation_finished.connect(_on_logos_finished)

func _on_logos_finished(_anim_name):
	# Instance the MainMenu now
	main_menu_scene = preload("res://scenes/main_menu.tscn").instantiate()
	add_child(main_menu_scene)
	main_menu_scene.z_index = -1
	main_menu_scene.visible = true  # show it under overlay

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
