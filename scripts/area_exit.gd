extends Area2D

func _on_body_entered(body: Node2D):
	if body is PlayerController:
		GameManager.end_level()

		if GameManager.level < GameManager.total_levels:
			GameManager.level += 1
			SceneManager.change_scene("res://scenes/levels/level_%d.tscn" % GameManager.level)
			GameManager.start_level(GameManager.level)
		else:
			SceneManager.change_scene("res://scenes/game_complete.tscn")
