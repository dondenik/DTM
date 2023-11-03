extends "res://NPC.gd"

var enemy = load("res://Enemy.tscn")

func post_dialogue_func():
	await timer(0.5)
	self.rotation = Vector3(0,0,0)
	get_parent().get_parent().rotation = Vector3(0,0,0)
	self.move_along_path = true
	
	# make it so the boat man wont take me to Babylon
	
	self.get_node("../../../Raft Guy").has_money = false

func post_destination_func():
	var thief = enemy.instantiate()
	self.hide()
	thief.position = self.position

func timer(seconds):
	await get_tree().create_timer(seconds).timeout
