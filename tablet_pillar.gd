extends Node3D

func _ready():
	var tween = get_tree().create_tween()
	#await timer(0.5)
	tween.tween_property($tablet, "position", Vector3(0.0, 1.5, 0.0), 2.0)
	await timer(2)
	self.queue_free()

func timer(seconds):
	await get_tree().create_timer(seconds).timeout
	
