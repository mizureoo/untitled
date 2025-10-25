extends Area2D

@onready var timer: Timer = $Timer
var spawn_point: Node2D
var player_to_respawn: PlayerController = null

func _ready():
	spawn_point = get_tree().current_scene.get_node_or_null("SpawnPoint")
	if not spawn_point:
		push_error("SpawnPoint not found in this scene!")

func _on_body_entered(body: Node2D):
	if body is PlayerController and not body.is_dead:
		player_to_respawn = body
		body.die()  # handles fade-out
		timer.start()

func _on_timer_timeout():
	timer.stop()
	if not player_to_respawn:
		return

	if GameManager.player_health > 0:
		# Respawn player
		player_to_respawn.global_position = spawn_point.global_position
		player_to_respawn.is_dead = false
		player_to_respawn.set_process(true)
		player_to_respawn.set_physics_process(true)

		# Fade-in effect
		var tween = create_tween()
		player_to_respawn.modulate = Color(1, 1, 1, 0)
		tween.tween_property(player_to_respawn, "modulate:a", 1.0, 0.6)
	else:
		GameManager.end_level()
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")
