extends CanvasLayer

@onready var transition_animation: AnimationPlayer = $TransitionAnimation

func change_scene(target: String, anim_name: String = "fade") -> void:
	transition_animation.play(anim_name)
	await transition_animation.animation_finished
	get_tree().change_scene_to_file(target)
	transition_animation.play_backwards(anim_name)
