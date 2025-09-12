extends Area2D

const FILE_BEGIN = "res://scenes/levels/level_"

func _on_body_entered(body: Node2D):
	if body is PlayerController:
		# End level and save stats
		GameManager.end_level()
		GameManager.level += 1

		var next_level_path = FILE_BEGIN + str(GameManager.level) + ".tscn"

		if ResourceLoader.exists(next_level_path):
			SceneManager.change_scene(next_level_path)
			GameManager.start_level(GameManager.level)
		else:
			# Completed last level
			SceneManager.change_scene("res://scenes/GameComplete.tscn")
