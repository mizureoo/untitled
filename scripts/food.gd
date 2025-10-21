extends Area2D

@export var food_id: String = ""  # Optional override

func _ready():
	# Auto-generate a unique ID if none was set
	if food_id == "":
		food_id = _generate_auto_id()

	# Ensure the save dictionary has a "collected_food" list
	if not SaveManager.data.has("collected_food"):
		SaveManager.data["collected_food"] = []

	# Hide/remove this food if it’s already collected
	if food_id in SaveManager.data["collected_food"]:
		queue_free()

func _on_body_entered(body: Node2D):
	if body is PlayerController:
		GameManager.add_score()

		# Add this food to the collected list (only once)
		if not food_id in SaveManager.data["collected_food"]:
			SaveManager.data["collected_food"].append(food_id)
			SaveManager.save_game()

		queue_free()

func _generate_auto_id() -> String:
	# Use scene name + position to create a unique ID per level
	var scene_name = get_tree().current_scene.name if get_tree().current_scene else "unknown_scene"
	var pos_hash = str(global_position.x) + "_" + str(global_position.y)
	return scene_name + "_" + pos_hash
