extends "res://NPC.gd"

var gave_copper = false

func post_dialogue_func():
	self.gave_copper = true
	self.dialogue_enable = false
	Global.sub_quest = "Return to Nanni"
	Global.main_quest = "Deliver the copper to Nanni"
	$"../CharacterBody3D".ui.quest_update()
