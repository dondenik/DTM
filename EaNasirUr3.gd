extends "res://NPC.gd"

var talked_to = false

func post_dialogue_func():
	get_node("../TimerControlNode").timer_on = false
	Global.sub_quest = "Return to Nanni"
	Global.main_quest = "Tell Nanni of Ea Nasir's refusal"
	$"../CharacterBody3D".ui.quest_update()
	self.talked_to = true
