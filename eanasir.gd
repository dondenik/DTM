extends "res://Scripts/Enemy.gd"

var tablet = preload("res://tablet.tscn")

func _ready():
	$Sprite3D.texture = $Sprite3D/SubViewport.get_texture()
	$Sprite3D/SubViewport/Health.value = 100 - health
	$mesoman1/mesoman1_Reference/Skeleton3D/BoneAttachment3D/copper_axe/Area3D/CollisionShape3D.disabled = true
	self.AGGRO_DIST = 0

func extension_func():
	timer_func(2, attack_tablet)

func timer(seconds):
	await get_tree().create_timer(seconds).timeout

func timer_func(seconds, fn: Callable):
	await get_tree().create_timer(seconds).timeout
	fn.call()

func attack_tablet():
	create_tablet()
	timer_func(2, attack_tablet)

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
