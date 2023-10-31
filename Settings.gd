extends VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	for box in get_children():
		box.get_node("TextEdit").text = (InputMap.action_get_events("roll")[0].as_text()[0])
