extends Area3D

var finished_start_animation = 0

func _process(delta):
	#if finished_start_animation == 0:
	#	var player_position = get_parent().get_node("CharacterBody3D").position
	#	player_position.y += 1.5
	#	var target_vector = global_position.direction_to(player_position)
	#	var target_basis = Basis.looking_at(target_vector)
	#	target_basis = target_basis.get_rotation_quaternion()
	#	# commented out lines prevent uo and down rotation
	#	#target_basis.x = 0
	#	#target_basis.z = 0
	#	basis = basis.slerp(target_basis, 1 * delta).get_rotation_quaternion()
	
	
	
	self.position += self.transform.basis.z * 9 * finished_start_animation * delta


func _on_area_3d_body_entered(body):
	finished_start_animation = 1
