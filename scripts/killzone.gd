extends Area2D

@onready var timer: Timer = $Timer
var spawn_point: Node2D
var player_to_respawn: Node = null

func _ready():
	# Find SpawnPoint safely from the scene root
	spawn_point = get_tree().current_scene.get_node("SpawnPoint")
	if not spawn_point:
		push_error("SpawnPoint not found in this scene!")

func _on_body_entered(body: Node2D):
	if body is PlayerController:
		GameManager.lose_life()
		player_to_respawn = body
		body.set_process(false)
		body.set_physics_process(false)
		timer.start()

func _on_timer_timeout():
	timer.stop()
	if GameManager.player_health > 0:
		# Respawn player
		player_to_respawn.global_position = spawn_point.global_position
		player_to_respawn.set_process(true)
		player_to_respawn.set_physics_process(true)
	else:
		# Full death
		GameManager.end_level()
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")
