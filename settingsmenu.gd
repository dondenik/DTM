extends VBoxContainer


# Called when the node enters the scene tree for the first time.
func _input(event):
	if event.is_action_pressed("pause"):
		get_tree().change_scene_to_file("res://main_menu.tscn")
