extends Control


func set_speaker(speaker):
	$SpeakerName.text = speaker.rstrip("0123456789")

func _ready():
	$Dialogue.set_use_bbcode(true)
	$Dialogue.add_theme_font_size_override("normal_font_size", int(round(23*Global.font_scale)))

func display_text(text, id, speaker):
	set_speaker(speaker)
	$Dialogue.text = text
	$Dialogue.visible_characters = 0
	self.show()
	var current_id = id
	for letter in text:
		if get_parent().dia_counter == current_id:
			$Dialogue.visible_characters += 1
			await get_tree().create_timer(0.01).timeout

func hide_dialogue():
	self.hide()
