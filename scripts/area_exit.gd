extends Area2D

const FILE_BEGIN = "res://scenes/levels/level_"

func _on_body_entered(body: Node2D) -> void:
	if body is PlayerController:
		print("The player has entered the area exit")
		var current_scene_file = get_tree().current_scene.scene_file_path
		var next_level_number = current_scene_file.to_int() + 1
		var next_level_path = FILE_BEGIN + str(next_level_number) + ".tscn"

		if ResourceLoader.exists(next_level_path):
			SceneManager.change_scene(next_level_path)
		else:
			print("Game Complete!")
