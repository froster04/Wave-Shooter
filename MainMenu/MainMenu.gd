extends Node2D

export var main_game_scene : PackedScene

onready var fade_animation = $AnimationPlayer

func _on_Play_button_down():
	$Click.play()
	fade_animation.play("fade_in")
	$Transition_timer.start()
	$Scene_change_timer.start()

func _on_Quit_button_down():
	get_tree().quit()


func _on_Options_button_down():
	$Click.play()
	fade_animation.play("fade_in")
	$Transition_timer.start()

func _on_Transition_timer_timeout():
	fade_animation.play("fade_out")
	


func _on_Scene_change_timer_timeout():
	get_tree().change_scene(main_game_scene.resource_path)
