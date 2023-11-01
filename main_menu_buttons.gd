extends GridContainer




func _on_button_pressed():
	get_tree().change_scene_to_packed(preload("res://settings.tscn"))


func _on_button_2_pressed():
	get_tree().change_scene_to_packed(preload("res://main.tscn"))


func _on_button_3_pressed():
	get_tree().quit()
