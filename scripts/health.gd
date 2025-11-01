extends Area2D

@export var heart_id: String = ""  # Optional override

func _ready():
	# Auto-generate a unique ID if none was set
	if heart_id == "":
		heart_id = _generate_auto_id()

	# Ensure SaveManager has a "collected_hearts" list
	if not SaveManager.data.has("collected_hearts"):
		SaveManager.data["collected_hearts"] = []

	# Hide this heart if it's already collected in save
	if heart_id in SaveManager.data["collected_hearts"]:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body is PlayerController:
		GameManager.add_health()  # Give player 1 heart
		GameManager.collect_heart(heart_id)  # Track in GameManager runtime

		# Mark it as collected in the current session (not yet saving to file)
		if not heart_id in SaveManager.data["collected_hearts"]:
			SaveManager.data["collected_hearts"].append(heart_id)

		# Play sound, then remove
		$HealSound.play()
		await get_tree().create_timer(0.60).timeout
		queue_free()

func _generate_auto_id() -> String:
	var scene_name = str(get_tree().current_scene.name) if get_tree().current_scene else "unknown_scene"
	var pos_hash = str(global_position.x) + "_" + str(global_position.y)
	return scene_name + "_" + pos_hash
