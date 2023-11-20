extends Area3D



func _on_body_entered(body):
	Global.main_quest = "Deliver the complaint tablet to Ea-Nasir"
	Global.sub_quest = "Confont Ea-Nasir"
	Global.checkpointscene = "res://bossfight.tscn"
	$"../CharacterBody3D".ui.quest_update()
	get_tree().change_scene_to_file("res://bossfight.tscn")

