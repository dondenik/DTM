extends RichTextLabel


func _ready():
	text = "Press %s to Talk"
	text = text % (InputMap.action_get_events("roll")[0].as_text()[0])
	print(InputMap.action_get_events("roll")[0].as_text()[0])
