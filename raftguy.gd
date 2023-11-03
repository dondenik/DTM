extends "res://NPC.gd"

var has_money = true
var times_broke = 0

func post_dialogue_func():
	if has_money:
		self.npc_dialogue_options.append("Alright let's go!")
		self.dialogue = self.npc_dialogue_options[self.npc_dialogue_counter + 1]
		# switch to babylon and fade out and stuff
	if not has_money and times_broke == 0:
		times_broke = 1
		self.npc_dialogue_options.append("Come back to me once you get your money back.")
		self.dialogue = "Your money got stolen? Doesn't matter to me, no pay, no ferry."
		self.npc_dialogue_counter -= 2
