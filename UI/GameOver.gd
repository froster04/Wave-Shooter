extends Node2D

onready var fade_animation = $AnimationPlayer

func _on_PlayAgain_button_down():
	fade_animation.play("fade_in")
	$Click.play()
	$Scene_change_timer.start()




func _on_Menu_button_down():
	fade_animation.play("fade_in")
	$Transition_timer.start()
	$Menu_transition_timer.start()


func _on_Quit_button_down():
	get_tree().quit()

func _on_Transition_timer_timeout():
	fade_animation.play("fade_out")

func _on_Scene_change_timer_timeout():
	get_tree().change_scene("res://Arena/Arena.tscn")


func _on_Menu_transition_timer_timeout():
	get_tree().change_scene("res://UI/MainMenu.tscn")
