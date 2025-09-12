extends Area2D

@onready var spawn_point: Node2D = $"../SpawnPoint"
@onready var timer: Timer = $Timer
var player_to_respawn: Node = null

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
		# Full death → record stats and go to Game Over
		GameManager.end_level()  
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")
