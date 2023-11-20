extends "res://NanniUr3.gd"


func post_dialogue_func():
	Global.main_quest = "Take the complaint tablet to Ea Nasir"
	Global.sub_quest = "Find a way to the port"
	$"../CharacterBody3D".ui.quest_update()
