extends Button

# Called when the node enters the scene tree for the first time.

#var action = get_parent().get_node("RichTextLabel").text.to_lower().replace(" ", "_")


func _ready():
	set_process_unhandled_key_input(false)
	display_current_key()

func _toggled(button_pressed):
	set_process_unhandled_key_input(button_pressed)
	if button_pressed:
		text = "... Key"
		release_focus()
	else:
		display_current_key()

func _unhandled_key_input(event):
	remap_action_to(event)
	button_pressed = false

func remap_action_to(event):
	# We first change the event in this game instance.
	InputMap.action_erase_events(get_parent().get_node("RichTextLabel").text.to_lower().replace(" ", "_"))
	InputMap.action_add_event(get_parent().get_node("RichTextLabel").text.to_lower().replace(" ", "_"), event)

func display_current_key():
	var current_key = InputMap.action_get_events(get_parent().get_node("RichTextLabel").text.to_lower().replace(" ", "_"))[0].as_text()
	text = "%s Key" % current_key
