extends Area3D

var finished_start_animation = 0
var homing = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if homing == true or finished_start_animation == 0:
		var player_position = get_parent().get_node("CharacterBody3D").position
		player_position.y += 1.5
		var target_vector = global_position.direction_to(player_position)
		var target_basis = Basis.looking_at(target_vector)
		target_basis = target_basis.get_rotation_quaternion()
		# commented out lines prevent uo and down rotation
		#target_basis.x = 0
		#target_basis.z = 0
		basis = basis.slerp(target_basis, 1 * delta).get_rotation_quaternion()
	
	
	
	self.position -= self.transform.basis.z * 1.0 * finished_start_animation
