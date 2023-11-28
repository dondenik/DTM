extends Node3D

var timer_on = false
var start_time = 50.0
var time = 0.0

func _on_nanni_timer_start():
	self.timer_on = true
	self.time = self.start_time

func _process(delta):
	if self.timer_on and self.time > 0.0:
		self.time -= delta
		Global.sub_quest = "Time till Ea Nasir leaves: " + str(self.time).substr(0, 4)
		$"../CharacterBody3D".ui.quest_update()
		if self.time <= 0.0:
			# kill the guy
			get_node("../CharacterBody3D").die()
