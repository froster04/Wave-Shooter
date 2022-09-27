extends Node

var node_creation_parent = null
var player = null
var points = 0
var camera = null
var highscore = 0

func instance_node(node, location, parent):
	var node_instance = node.instance()
	parent.add_child(node_instance)
	node_instance.global_position = location
	return node_instance

func save():
	var save_dictionary = {
		"highscore" : highscore
	}
	return save_dictionary

func save_game():
	var save_game = File.new()
	save_game.open_encrypted_with_pass("user://savegame.save", File.WRITE, "dontcheat")
	save_game.store_line(to_json(save()))
	save_game.close()

func load_game():
	var save_game = File.new()
	if not save_game.file_exists("user://savegame.save"):
		print("Save not found!")
		return
	save_game.open_encrypted_with_pass("user://savegame.save", File.READ, "dontcheat")
	
	var current_line = parse_json(save_game.get_line())
	highscore = current_line["highscore"]
	save_game.close()
