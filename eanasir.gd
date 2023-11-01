extends "res://Scripts/Enemy.gd"

var tablet = preload("res://tablet.tscn")

func extension_func():
	self.AGGRO_DIST = 0
	timer_func(2, create_tablet)
	timer_func(4, create_tablet)

func timer(seconds):
	await get_tree().create_timer(seconds).timeout

func timer_func(seconds, fn: Callable):
	await get_tree().create_timer(seconds).timeout
	fn.call()

func create_tablet():
	var tab = tablet.instantiate()
	self.add_sibling(tab)
	tab.position = self.position
	tab.rotation = self.rotation
	self.create_tween().tween_property(tab, "position", Vector3(self.position.x, self.position.y + 3, self.position.z), 4)
	await timer(5)
	tab.finished_start_animation = 1
	await timer(15)
	tab.queue_free()
