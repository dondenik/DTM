extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const TURNING_SPEED = 0.15 #should be between 0-1
const FALL_HEIGHT_OFFSET = 0 #how far the player can fall past the point they intially jumped from before falling
const ROLL_DURATION = 0.9
const SPRINT_SPEED = 5.0 #this is added to SPEED when sprinting
const ROLL_COOLDOWN_DURATION = 0.23 # time between rolling
const ATTACK_DURATION = 1.5
const ATTACK_COOLDOWN_DURATION = 0.23

var jump_starting_point = self.position.y
var roll_timer = 0
var roll_cooldown = 0
var attack_cooldown = 0
var attack_timer = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event.is_action_pressed("pause"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Get the input direction and handle the movement/deceleration.
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	
	# Define state related variables
	# These are boolean values stored in integers for easier usage
	var is_running = int((abs(input_dir.x) or abs(input_dir.y)))
	var in_water = 0 # replace with water detection
	var is_sprinting = int(Input.is_action_pressed("sprint"))
	var on_ground = is_on_floor() # need to test this but should work
	var is_jumping = (not (self.position.y < (jump_starting_point - FALL_HEIGHT_OFFSET))) and (not on_ground)
	var is_falling = (not on_ground) and (not is_jumping)
	var is_rolling = int(roll_timer > 0)
	var is_attacking = int(attack_timer > 0)
	
	
		# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor() and not is_rolling:
		jump_starting_point = self.position.y
		velocity.y = JUMP_VELOCITY
	
#	get_node("mesoman1/mesoman1_Reference/Skeleton3D/BoneAttachment3D/Node3D/Area3D/CollisionShape3D").disabled = not is_attacking
	
	if Input.is_action_pressed("roll") and roll_timer <= 0 and on_ground and roll_cooldown <= 0:
			roll_timer = ROLL_DURATION
			attack_timer = 0
			$AnimationPlayer.play("Roll", -1, 1.7)
	
	if Input.is_action_pressed("attack") and attack_cooldown <= 0 and attack_timer <= 0 and not is_rolling:
			attack_timer = ATTACK_DURATION
			$AnimationPlayer.play("Thrust")
	
	roll_timer -= (1 * delta * is_rolling)
	roll_cooldown -= (1 * delta * int(not is_rolling))
	
	attack_timer -= (1 * delta * is_attacking)
	attack_cooldown -= (1 * delta * int(not is_attacking))
	
	if is_rolling or roll_timer > 0:
		input_dir.y -= 1
		roll_cooldown = ROLL_COOLDOWN_DURATION
	elif is_attacking or attack_timer > 0:
		input_dir.y = 0
		print("aarat")
		attack_cooldown = ATTACK_COOLDOWN_DURATION
	elif in_water:
		$AnimationPlayer.play("Swim")
	elif on_ground:
		if is_running:
			if is_sprinting:
				$AnimationPlayer.play("Sprint")
			else:
				$AnimationPlayer.play("Run")
		else:
			$AnimationPlayer.play("Idle")
	elif is_falling:
		$AnimationPlayer.play("Fall")
	elif is_jumping:
		$AnimationPlayer.play("Jump")


	# Change Player Rotation to match Camera if moving
	self.rotation.y = lerp(self.rotation.y, self.rotation.y + (transform.basis * Vector3(input_dir.x, 0, input_dir.y) +  $CameraRoot.rotation.y * is_running, TURNING_SPEED)
	$CameraRoot.rotation.y -= $CameraRoot.rotation.y  * TURNING_SPEED * is_running
	
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * (SPEED + (is_sprinting * SPRINT_SPEED))
		velocity.z = direction.z * (SPEED + (is_sprinting * SPRINT_SPEED))
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
