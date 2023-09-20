extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const TURNING_SPEED = 5.0
const ATTACK_COOLDOWN = 2

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var health = 100

var attack_cooldown = 0
var is_attacking = 0

func _ready():
	$Sprite3D.texture = $Sprite3D/SubViewport.get_texture()
	$Sprite3D/SubViewport/Health.value = 100 - health

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# input_dir, (0, -1) = towards player
	var input_dir = Vector2(0, -1)

	var is_running = int((abs(input_dir.x) or abs(input_dir.y)))
	

	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	var player_position = get_parent().get_node("CharacterBody3D").position
	var target_vector = global_position.direction_to(player_position)
	var target_basis = Basis.looking_at(target_vector)
	target_basis = target_basis.get_rotation_quaternion()
	target_basis.x = 0
	target_basis.z = 0
	basis = basis.slerp(target_basis, TURNING_SPEED * delta).get_rotation_quaternion()
	
	attack_cooldown -= 1 * delta
	
	# check if near player:
	var distance_to_player = self.global_position.distance_to(player_position)
	if distance_to_player < 2:
		if attack_cooldown <= 0:
			$AnimationPlayer.play("Slash")
			is_attacking = 1
			attack_cooldown = ATTACK_COOLDOWN
		else:
			$AnimationPlayer.queue("Fight Idle")
	elif is_running:
		$AnimationPlayer.play("Run")
	
	if direction:
		velocity.x = direction.x * SPEED * int(not (distance_to_player < 2))
		velocity.z = direction.z * SPEED * int(not (distance_to_player < 2))
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()


func _on_area_3d_area_entered(area):
	health -= 10
	$Sprite3D/SubViewport/Health.value = 100 - health
