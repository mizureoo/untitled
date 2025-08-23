extends CanvasLayer

@onready var transition_animation: AnimationPlayer = $TransitionAnimation

func change_scene(target: String) -> void: 
	transition_animation.play("fade") 
	await transition_animation.animation_finished
	get_tree().change_scene_to_file(target)
	transition_animation.play_backwards("fade")
