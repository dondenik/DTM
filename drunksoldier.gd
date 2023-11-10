extends "res://NPC.gd"

var enemy = load("res://thiefEnemy.tscn")

func post_dialogue_func():
	Global.sub_quest = "Eh aahh youu wannnnaa go maaatee"
	$"../../../CharacterBody3D".ui.quest_update()
	self.move_along_path = false
	var thief = enemy.instantiate()
	self.hide()
	thief.position = self.global_position
	self.get_node("../../../../Node3D2").add_child(thief)
	self.queue_free()


func timer(seconds):
	await get_tree().create_timer(seconds).timeout
