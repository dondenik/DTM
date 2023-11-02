extends Control


func set_speaker(speaker):
	$SpeakerName.text = speaker

func _ready():
	$Dialogue.set_use_bbcode(true)

func display_text(text, id):
	$Dialogue.text = text
	$Dialogue.visible_characters = 0
	self.show()
	var current_id = id
	for letter in text:
		if get_parent().dia_counter == current_id:
			$Dialogue.visible_characters += 1
			await get_tree().create_timer(0.02).timeout

func hide_dialogue():
	self.hide()
