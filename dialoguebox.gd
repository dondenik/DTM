extends Control


func set_speaker(speaker):
	$SpeakerName.text = speaker


var letterqueue = []

func display_text(text):
	for letter in text:
		letterqueue.append(letter)
		$Dialogue.text = $Dialogue.text + letter
		await get_tree().create_timer(0.1).timeout
