extends "res://Scripts/Enemy.gd"

func post_death_func():
	Global.sub_quest = "Navigate to the port"
	$"../CharacterBody3D".ui.quest_update()
	self.get_node("../Raft Guy").has_money = true
