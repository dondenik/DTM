extends Node3D

var pillar = preload("res://tablet_pillar.tscn")

var pillarize = false

func create_pillar():
	var pil = pillar.instantiate()
	self.add_sibling(pil)
	pil.position.x = randf_range(5.0, 23.0)
	pil.position.z = randf_range(4.0, -3.0)
	pil.rotation.y = randf_range(-2.0, 2.0)

func timer(seconds):
	await get_tree().create_timer(seconds).timeout

func start_pillarising():
	self.pillarize = true
	while self.pillarize == true:
		create_pillar()
		create_pillar()
		create_pillar()
		create_pillar()
		create_pillar()
		create_pillar()
		create_pillar()
		create_pillar()
		create_pillar()
		create_pillar()
		create_pillar()
		create_pillar()
		create_pillar()
		create_pillar()
		create_pillar()
		create_pillar()
		create_pillar()
		create_pillar()
		create_pillar()
		create_pillar()
		await timer(2)
