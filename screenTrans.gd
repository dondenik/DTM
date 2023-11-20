extends ColorRect

func change_scene_to_file(path):
	self.material["shader_parameter/progress"] = 1.0
	
	var tween = create_tween()
	tween.tween_property(
		self.material, 
		"shader_parameter/progress", 
		1.0, 
		1
	).from(0.0).set_trans(Tween.TRANS_SINE)
	
	await tween.finished
	
	
	get_tree().change_scene_to_file(path)

func _ready():
	var tween = create_tween()
	tween.tween_property(
		self.material, 
		"shader_parameter/progress", 
		0, 
		1
	).from(1.0).set_trans(Tween.TRANS_SINE)
