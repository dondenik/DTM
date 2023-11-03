extends "res://NPC.gd"

func post_dialogue_func():
	self.rotation = Vector3(0,0,0)
	get_parent().get_parent().rotation = Vector3(0,0,0)
	self.move_along_path = true
