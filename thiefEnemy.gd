extends "res://Scripts/Enemy.gd"

func post_death_func():
	self.get_node("../Raft Guy").has_money = true
