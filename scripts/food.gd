extends Area2D

func _on_body_entered(body: Node2D):
	if body is PlayerController:
		GameManager.add_score()
		queue_free()  # permanently remove pizza until full reset
