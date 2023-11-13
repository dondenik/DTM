extends "res://NPC.gd"

func post_dialogue_func():
	Global.sub_quest = "Find a way to the port"
	Global.main_quest = "Collect the copper from Ea Nasir"
	$"../CharacterBody3D".ui.quest_update()
	self.npc_dialogue_options = ["Do you have the copper yet?"]
	if self.get_node("../Ea Nasir").gave_copper:
		self.npc_dialogue_options.append("Good job, now let me take a look at that copper...")
		# Ur 3 swap
	else:
		self.npc_dialogue_options.append("Go collect the copper from Ea Nasir.")
	self.npc_dialogue_counter = 0
	self.dialogue = self.npc_dialogue_options[self.npc_dialogue_counter]
