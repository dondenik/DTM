extends "res://NPC.gd"

func post_dialogue_func():
	Global.main_quest = "Wait for the copper to arrive"
	Global.sub_quest = "Talk to Nanni"
	Global.checkpointscene = "res://Ur 2.tscn"
	$"../CharacterBody3D".ui.quest_update()
	get_tree().change_scene_to_file("res://Ur 2.tscn")
