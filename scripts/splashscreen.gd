extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var overlay: ColorRect = $ColorRect
var main_menu_scene: Control = null

func _ready():
	animation_player.play("fade_out")
	animation_player.animation_finished.connect(_on_logos_finished)

func _on_logos_finished(_anim_name):
	main_menu_scene = preload("res://scenes/main_menu.tscn").instantiate()
	add_child(main_menu_scene)
	main_menu_scene.z_index = -1
	main_menu_scene.visible = true

	var tween = get_tree().create_tween()
	tween.tween_property(overlay, "modulate:a", 0, 1.5) 
	tween.finished.connect(_finish_splash)

func _finish_splash():
	$GodotLogo.queue_free()
	$MadeWithGodot.queue_free()
	$Logo.queue_free()
	overlay.queue_free()
