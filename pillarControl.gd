extends Node3D

var pillar = preload("res://tablet_pillar.tscn")

func _ready():
	while true:
		create_pillar()
		await timer(3)

func create_pillar():
	var pil = pillar.instantiate()
	self.add_sibling(pil)
	pil.position.x = randf_range(5.0, 23.0)
	pil.position.z = randf_range(4.0, -3.0)

func timer(seconds):
	await get_tree().create_timer(seconds).timeout
