extends "res://NPC.gd"

var phase_counter = 1

func post_dialogue_func():
	if self.get_node("../Ea Nasir Enemy").health < 99:
		phase_counter += 1
	if phase_counter == 2:
		self.get_node("../Ea Nasir Enemy").throw_tablets = true
		self.get_node("../Ea Nasir Enemy").extension_func()
	elif phase_counter == 3:
		self.get_node("../Ea Nasir Enemy").throw_tablets = false
		self.get_node("../pillarControl").start_pillarising()
	elif phase_counter == 4:
		%screenTrans.change_scene_to_file("res://main_menu.tscn")
	self.dialogue_enable = false
