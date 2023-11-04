extends GridContainer

func _ready():
	for container in get_children():
		container.get_node("RichTextLabel").add_theme_font_size_override("normal_font_size", int(round(24 * (Global.font_scale))))

# Called when the node enters the scene tree for the first time.
func _input(event):
	if event.is_action_pressed("pause"):
		get_tree().change_scene_to_file("res://main_menu.tscn")


func _on_h_slider_value_changed(value):
	Global.font_scale = value/100
	for container in get_children():
		container.get_node("RichTextLabel").add_theme_font_size_override("normal_font_size", int(round(24 * (Global.font_scale))))

