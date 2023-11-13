extends HBoxContainer




func _on_button_pressed():
	get_tree().change_scene_to_file(Global.checkpointscene)


func _on_button_2_pressed():
	get_tree().change_scene_to_file("res://main_menu.tscn")
