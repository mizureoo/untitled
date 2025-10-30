extends Area2D

@export var food_id: String = ""  # Optional override

func _ready():
	# Auto-generate a unique ID if none was set
	if food_id == "":
		food_id = _generate_auto_id()

	# Ensure SaveManager has a "collected_food" list
	if not SaveManager.data.has("collected_food"):
		SaveManager.data["collected_food"] = []

	# Hide this food if it's already collected in save
	if food_id in SaveManager.data["collected_food"]:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body is PlayerController:
		GameManager.add_score()
		GameManager.collect_food(food_id)  # store in GameManager runtime list

		# Update SaveManager's runtime data only, not file
		if not food_id in SaveManager.data["collected_food"]:
			SaveManager.data["collected_food"].append(food_id)


		# Play the pickup sound
		$PickupSound.play()
		await get_tree().create_timer(0.17).timeout
		queue_free()

func _generate_auto_id() -> String:
	var scene_name = str(get_tree().current_scene.name) if get_tree().current_scene else "unknown_scene"
	var pos_hash = str(global_position.x) + "_" + str(global_position.y)
	return scene_name + "_" + pos_hash
