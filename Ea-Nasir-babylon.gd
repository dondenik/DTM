extends "res://NPC.gd"

func _ready():
	self.body_in_talking_range.connect(player._in_dialogue_range)
	self.body_left_talking_range.connect(player._left_dialogue_range)
	player.request_dialogue.connect(_on_dialogue_request)
	self.return_dialogue_request.connect(player._recieve_dialogue)
	$Sprite3D.texture = $Sprite3D/SubViewport.get_texture()
	self.dialogue = npc_dialogue_options[npc_dialogue_counter]
	Global.main_quest = "Deliver Ea-Nasir the money"
	Global.sub_quest = "Find Ea-Nasir's house"
	$"../CharacterBody3D".ui.quest_update()

func post_dialogue_func():
	Global.main_quest = "Wait for the copper to arrive"
	Global.sub_quest = "Talk to Nanni"
	Global.checkpointscene = "res://Ur 2.tscn"
	$"../CharacterBody3D".ui.quest_update()
	$"../CharacterBody3D".screenTrans.change_scene_to_file("res://Ur 2.tscn")
