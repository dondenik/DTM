extends RichTextLabel

func _ready():
	var loc = Global.checkpointscene
	loc = loc.trim_prefix("res://").trim_suffix(".tscn").trim_suffix(" zone #").rstrip("0123456789").rstrip(" ")
	self.text = "[center]" + loc
