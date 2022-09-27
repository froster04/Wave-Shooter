extends Node2D

var is_paused = false
onready var fade_animation = $AnimationPlayer

func _process(delta):
	if Input.is_action_pressed("Esc"):
		get_tree().paused = true
		self.visible = true

func _on_Resume_button_down():
	get_tree().paused = false
	self.visible = false
	$Click.play()

func _on_Menu_button_down():
	get_tree().paused = false
	fade_animation.play("fade_in")
	$Scene_change_timer.start()

func _on_Quit_button_down():
	get_tree().quit()

func _on_Transition_timer_timeout():
	fade_animation.play("fade_out")

func _on_Scene_change_timer_timeout():
	get_tree().change_scene("res://UI/MainMenu.tscn")
