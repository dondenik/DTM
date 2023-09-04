extends Node3D




# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	var player_position = get_parent().get_node("CharacterBody3D").position
	var target_vector = global_position.direction_to(player_position)
	var target_basis = Basis.looking_at(target_vector)
	target_basis = target_basis.get_rotation_quaternion()
	target_basis.x = 0
	target_basis.z = 0
	basis = basis.slerp(target_basis, 2.5 * delta).get_rotation_quaternion()

func _on_area_3d_area_entered(area):
	print("beeeeeeeen hit")
