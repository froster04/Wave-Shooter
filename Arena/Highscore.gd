extends Label

func _ready():
	Global.load_game()
	text = "Highscore: " + String(Global.highscore)

func _process(delta):
	if Global.points > Global.highscore:
		Global.highscore = Global.points
