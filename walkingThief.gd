extends "res://NPC.gd"

var enemy = load("res://thiefEnemy.tscn")

func post_dialogue_func():
	Global.sub_quest = "Recover the money from the thief"
	$"../../../CharacterBody3D".ui.quest_update()
	await timer(0.5)
	self.rotation = Vector3(0,0,0)
	get_parent().get_parent().rotation = Vector3(0,0,0)
	self.move_along_path = true
	
	# make it so the boat man wont take me to Babylon
	
	self.get_node("../../../Raft Guy").has_money = false

func post_destination_func():
	self.move_along_path = false
	var thief = enemy.instantiate()
	self.hide()
	thief.position = self.global_position
	self.get_node("../../../../Node3D2").add_child(thief)
	self.queue_free()

func timer(seconds):
	await get_tree().create_timer(seconds).timeout
