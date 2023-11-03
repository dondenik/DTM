extends "res://NPC.gd"

func post_dialogue_func():
	Global.sub_quest = "Leave Nanni's house"
	Global.main_quest = "Find a way to the port"
	$"../CharacterBody3D".ui.quest_update()
