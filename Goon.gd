extends "res://NPC.gd"

func post_dialogue_func():
	await timer(0.8)
	self.hide()
	var old_pos = self.position
	self.position.z += 100
	get_parent().get_node("goon3").position = old_pos
	get_parent().get_node("goon3").show()
	get_parent().get_node("goon1").get_node("Sprite3D").show()
	get_parent().get_node("goon2").get_node("Sprite3D").show()
	get_parent().get_node("goon3").get_node("Sprite3D").show()
	get_parent().get_node("goon3").AGGRO_DIST = 100
	get_parent().get_node("goon2").AGGRO_DIST = 100
	get_parent().get_node("goon1").AGGRO_DIST = 100
	self.queue_free()

func timer(seconds):
	await get_tree().create_timer(seconds).timeout
