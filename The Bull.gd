extends "res://NPC.gd"

func post_dialogue_func():
	await timer(0.8)
	self.hide()
	var old_pos = self.position
	self.position.z += 100
	get_parent().get_node("bull").position = old_pos
	get_parent().get_node("bull").show()
	get_parent().get_node("bull").AGGRO_DIST = 100
	self.queue_free()

func timer(seconds):
	await get_tree().create_timer(seconds).timeout
