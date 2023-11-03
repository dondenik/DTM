extends "res://NPC.gd"

func post_dialogue_func():
	await timer(0.8)
	self.hide()
	var old_pos = self.position
	old_pos.y -= 0.5
	self.position.z += 100
	get_parent().get_node("bull").position = old_pos
	get_parent().get_node("bull").show()
	get_parent().get_node("bull").AGGRO_DIST = 6
	get_parent().get_node("bull").scale = Vector3(2,2,2)
	self.queue_free()

func timer(seconds):
	await get_tree().create_timer(seconds).timeout
