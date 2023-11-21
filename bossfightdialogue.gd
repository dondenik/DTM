extends "res://NPC.gd"

var phase_counter = 0

func post_dialogue_func():
	phase_counter += 1
	if phase_counter == 2:
		self.get_node("../Ea Nasir").extension_func()
	elif phase_counter == 3:
		
