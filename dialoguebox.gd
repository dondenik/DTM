extends Control


func set_speaker(speaker):
	$SpeakerName.text = speaker


var letterqueue = []

func display_text(text):
	$Dialogue.text = ""
	letterqueue = []
	self.show()
	for letter in text:
		letterqueue.append(letter)
		$Dialogue.text = $Dialogue.text + letter
		await get_tree().create_timer(0.02).timeout

func hide_dialogue():
	self.hide()
