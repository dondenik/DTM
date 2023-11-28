extends "res://NPC.gd"

var enemy = load("res://thiefEnemy.tscn")

func post_dialogue_func():
	self.get_node("../bandit1").AGGRO_DIST = 10
	self.get_node("../bandit2").AGGRO_DIST = 10
	self.move_along_path = false
	var thief = enemy.instantiate()
	self.hide()
	thief.position = self.global_position
	self.get_node("../../Ur4Root").add_child(thief)
	self.queue_free()
