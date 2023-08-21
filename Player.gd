extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const TURNING_SPEED = 0.2 #should be between 0-1
const FALL_HEIGHT_OFFSET = 0 #how far the player can fall past the point they intially jumped from before falling

var jump_starting_point = self.position.y

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jump_starting_point = self.position.y
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	
	# Define state related variables
	# These are boolean values stored in integers for easier usage
	var is_running = int((abs(input_dir.x) or abs(input_dir.y)))
	var in_water = 0 # replace with water detection
	var is_sprinting = 0 # replace with sprint detection
	var on_ground = is_on_floor() # need to test this but should work
	var is_jumping = (not (self.position.y < (jump_starting_point - FALL_HEIGHT_OFFSET))) and (not on_ground)
	var is_falling = (not on_ground) and (not is_jumping)
	var is_rolling = 0 # replace with roll detection
	
	# Change Player Rotation to match Camera if moving
	self.rotation.y = lerp(self.rotation.y, self.rotation.y + $CameraRoot.rotation.y * is_running, TURNING_SPEED)
	$CameraRoot.rotation.y -= $CameraRoot.rotation.y  * TURNING_SPEED * is_running
	
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
