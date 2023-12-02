extends GridContainer


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_button_pressed():
	get_tree().change_scene_to_packed(preload("res://settings.tscn"))


func _on_button_2_pressed():
	%screenTrans.change_scene_to_file("Ur.tscn")


func _on_button_3_pressed():
	get_tree().quit()
