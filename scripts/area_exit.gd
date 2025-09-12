extends Area2D

func _on_body_entered(body: Node2D):
	if body is PlayerController:
		# End current level
		GameManager.end_level()

		if GameManager.level < GameManager.total_levels:
			# Go to next level
			GameManager.level += 1
			SceneManager.change_scene("res://scenes/levels/level_%d.tscn" % GameManager.level)
			GameManager.start_level(GameManager.level)
		else:
			# Last level completed → Game Complete scene
			SceneManager.change_scene("res://scenes/game_complete.tscn")
