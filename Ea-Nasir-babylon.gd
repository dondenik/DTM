extends "res://NPC.gd"

func _ready():
	Global.main_quest = "Deliver Ea-Nasir the money"
	Global.sub_quest = "Find Ea-Nasir's house"
	$"../CharacterBody3D".ui.quest_update()

func post_dialogue_func():
	Global.main_quest = "Wait for the copper to arrive"
	Global.sub_quest = "Talk to Nanni"
	Global.checkpointscene = "res://Ur 2.tscn"
	$"../CharacterBody3D".ui.quest_update()
	$"../CharacterBody3D".screenTrans.change_scene_to_file("res://Ur 2.tscn")
