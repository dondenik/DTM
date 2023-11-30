extends "res://Scripts/Enemy.gd"

var tablet = preload("res://tablet.tscn")

var eanasir_dialogue_things = ["Hmph you are tougher than you thought...", "Okay now things are getting serious!"]


func _ready():
	self.health = 30
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

func _on_area_3d_area_entered(area):
	if iframes <= 0:
		self.get_node("../Ea Nasir").npc_dialogue_options = [self.eanasir_dialogue_things[self.get_node("../Ea Nasir").phase_counter - 1]]
		self.get_node("../Ea Nasir").npc_dialogue_counter = 0
		self.get_node("../Ea Nasir").dialogue = self.get_node("../Ea Nasir").npc_dialogue_options[self.get_node("../Ea Nasir").npc_dialogue_counter]
		self.get_node("../Ea Nasir").dialogue_enable = true
		#self.get_node("../CharacterBody3D").velocity = Vector3(0,0,0)
		health -= 10
		iframes = HIT_STUN
		hitstun = HIT_STUN
		set_deferred("$mesoman1/mesoman1_Reference/Skeleton3D/BoneAttachment3D/copper_axe/Area3D/CollisionShape3D.disabled", true)
		$Sprite3D/SubViewport/Health.value = 100 - health
		self.get_node("../CharacterBody3D").velocity = Vector3(-1000, 300, 0)
		self.get_node("../CharacterBody3D").move_and_slide()
