extends Control


func _ready():
	$VBoxContainer/RichTextLabel.add_theme_font_size_override("normal_font_size", int(round(23*Global.font_scale)))
	$VBoxContainer/RichTextLabel.add_theme_font_size_override("normal_font_size", int(round(23*Global.font_scale)))
	quest_update()

func bar_update(health, stamina):
	$Health.value = 100 - health
	$Stamina.value = 100 - stamina

func quest_update():
	$VBoxContainer/RichTextLabel.text = Global.main_quest
	$VBoxContainer/RichTextLabel2.text = Global.sub_quest

