extends "res://NPC.gd"

var talked_to = false

func post_dialogue_func():
	get_node("../TimerControlNode").timer_on = false
	Global.sub_quest = "Return to Nanni"
	Global.main_quest = "Tell Nanni of Ea Nasir's refusal"
	$"../CharacterBody3D".ui.quest_update()
	self.talked_to = true

func _on_dialogue_request():
	if player_in_range and dialogue_enable:
		get_node("../TimerControlNode").timer_on = false
		return_dialogue_request.emit(self.dialogue, self.name)
		if npc_dialogue_mode == "sequential":
			if self.npc_dialogue_counter < len(self.npc_dialogue_options) - 1:
				self.npc_dialogue_counter += 1
				self.dialogue = self.npc_dialogue_options[self.npc_dialogue_counter]
			else:
				if no_repeating_enable:
					self.dialogue_enable = false
				post_dialogue_func()
