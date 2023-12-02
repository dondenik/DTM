extends Control


func _ready():
	$VBoxContainer/RichTextLabel.add_theme_font_size_override("normal_font_size", int(round(30*Global.font_scale)))
	$VBoxContainer/RichTextLabel2.add_theme_font_size_override("normal_font_size", int(round(30*Global.font_scale)))
	quest_update()
	if Global.colour_mode != -1:
		self.get_node("Bars").material = load("res://colourblind.tres")
		self.get_node("Bars").material.set_shader_parameter("mode", Global.colour_mode)
	
func bar_update(health, stamina):
	$Health.value = 100 - health
	$Stamina.value = 100 - stamina

func quest_update():
	$VBoxContainer/RichTextLabel.text = Global.main_quest
	$VBoxContainer/RichTextLabel2.text = Global.sub_quest

func show_pause_menu():
	$PauseMenu.show()

func hide_pause_menu():
	$PauseMenu.hide()

func _on_quit_to_menu_pressed():
	$screenTrans.change_scene_to_file("res://main_menu.tscn")


func _on_quit_to_desktop_pressed():
	get_tree().quit()
