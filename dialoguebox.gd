extends Control


func set_speaker(speaker):
	$SpeakerName.text = speaker


func display_text(text, id):
	$Dialogue.text = ""
	self.show()
	var current_id = id
	for letter in text:
		if get_parent().dia_counter == current_id:
			$Dialogue.text = $Dialogue.text + letter
			await get_tree().create_timer(0.02).timeout

func hide_dialogue():
	self.hide()
