extends CharacterBody3D

# ROLL CONSTANTS
const ROLL_DURATION = 0.9
const ROLL_COOLDOWN_DURATION = 0.23 # time between rolling
const ROLL_IFRAMES = 1

# ATTACK CONSTANTS
const ATTACK_DURATION = 1
const ATTACK_COOLDOWN_DURATION = 0.23
const HITSTUN = 1

# MOVEMENT CONSTANTS
const SPEED = 5.0
const JUMP_VELOCITY = 4
const TURNING_SPEED = 0.15 #should be between 0-1, higher = fast
const SPRINT_SPEED = 2.5 #this is added to SPEED when sprinting
const FALL_HEIGHT_OFFSET = 0 #how far the player can fall past the point they intially jumped from before falling

# STAMINA RECOVERY 
const STAMINA_RECOVERY = 50
const STAMINA_RECOVERY_CD = 0.3

# STAMINA COSTS
const ATTACK_STAMINA = 15
const ROLL_STAMINA = 20
const SPRINT_STAMINA = 10
const JUMP_STAMINA = 10

var jump_starting_point = self.position.y
var roll_timer = 0
var roll_cooldown = 0
var attack_cooldown = 0
var attack_timer = 0
var recovery_timer = 0
var fighting = 0
var iframes = 0
var hitstun = 0

var in_dialogue = 0
var in_dia_range = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var locked_dir = Vector2(0,0)
var locked_rot = 0

var stamina = 100
var health = 100

var dead = false 

var death_message = preload("res://death_message.tscn")
signal request_dialogue

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$UI.bar_update(health, stamina)
	

	

func _input(event):
	if event.is_action_pressed("pause"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		

func stamina_cost(cost):
	
	if stamina >= cost:
		stamina -= cost
		recovery_timer = STAMINA_RECOVERY_CD
		return true
	else:
		return false

func die():
	add_child(death_message.instantiate())
	$AnimationPlayer.play("Die")
	dead = true
	$CollisionShape3D.disabled = true

func _on_area_3d_area_entered(area):
	if iframes <= 0:
		health -= 10
		iframes = HITSTUN
		hitstun = HITSTUN
		$mesoman1/mesoman1_Reference/Skeleton3D/BoneAttachment3D/copper_axe/Area3D/CollisionShape3D.disabled = true


func _physics_process(delta):
		# Change compass input
	get_node("UI/Mesocompass").material.set_shader_parameter("direction", $CameraRoot.global_rotation.y)
	
	if not dead:
		
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
		var is_hitstun = int(hitstun > 0)
		
			# Handle Jump.
		if Input.is_action_just_pressed("jump") and is_on_floor() and not is_rolling:
			if stamina_cost(JUMP_STAMINA) == true:
				jump_starting_point = self.position.y
				velocity.y = JUMP_VELOCITY
			
	
		
		if Input.is_action_just_pressed("roll") and roll_timer <= 0 and on_ground and roll_cooldown <= 0:
			if in_dia_range == 0:
				if stamina_cost(ROLL_STAMINA) == true:
					roll_timer = ROLL_DURATION
					iframes = ROLL_IFRAMES
					attack_timer = 0
					$AnimationPlayer.play("Roll", -1, 1.7)
					self.rotation.y = self.rotation.y + ($CameraRoot.rotation.y - Vector3(input_dir.x, 0, input_dir.y).signed_angle_to(Vector3(0,0,-1), Vector3(0, 1, 0)))
					$CameraRoot.rotation.y -= ($CameraRoot.rotation.y - Vector3(input_dir.x, 0, input_dir.y).signed_angle_to(Vector3(0,0,-1), Vector3(0, 1, 0)))
					if input_dir == Vector2(0, 0):
						input_dir = Vector2(0, -1)
					locked_rot = $CameraRoot.rotation.y
					locked_dir = input_dir
			else:
				if in_dialogue == 0:
					in_dialogue = 1
					request_dialogue.emit()
	
	
		
		if Input.is_action_pressed("attack") and attack_cooldown <= 0 and attack_timer <= 0 and not is_rolling :
			if stamina_cost(ATTACK_STAMINA) == true:
				attack_timer = ATTACK_DURATION
				$AnimationPlayer.play("Slash")
				# make attacks rotate player
				self.rotation.y = self.rotation.y + ($CameraRoot.rotation.y - Vector3(input_dir.x, 0, input_dir.y).signed_angle_to(Vector3(0,0,-1), Vector3(0, 1, 0)))
				$CameraRoot.rotation.y -= ($CameraRoot.rotation.y - Vector3(input_dir.x, 0, input_dir.y).signed_angle_to(Vector3(0,0,-1), Vector3(0, 1, 0)))
				# -----------
				locked_dir = Vector2(0,0)
		
		
		roll_timer -= (1 * delta * is_rolling)
		roll_cooldown -= (1 * delta * int(not is_rolling))
		
		attack_timer -= (1 * delta * is_attacking)
		attack_cooldown -= (1 * delta * int(not is_attacking))
		
		iframes -= (1 * delta)
		iframes = iframes * int(iframes > 0)
		
		hitstun -= (1 * delta)
		hitstun = hitstun * int(hitstun > 0)
		
		if is_hitstun > 0:
			$AnimationPlayer.play("Armature|mixamo_com|Layer0_015 Retarget", 0.5)
			$mesoman1/mesoman1_Reference/Skeleton3D/BoneAttachment3D/copper_axe/Area3D/CollisionShape3D.disabled = true
			input_dir = Vector2(0,0)
		elif is_rolling or roll_timer > 0:
			input_dir = locked_dir
			roll_cooldown = ROLL_COOLDOWN_DURATION
		elif is_attacking or attack_timer > 0:
			input_dir = locked_dir
			attack_cooldown = ATTACK_COOLDOWN_DURATION
		elif in_water:
			$AnimationPlayer.play("Swim")
		elif on_ground:
			if is_running:
				$mesoman1/mesoman1_Reference/Skeleton3D/BoneAttachment3D/copper_axe/Area3D/CollisionShape3D.disabled = true
				if is_sprinting:
					$AnimationPlayer.play("Sprint")
					stamina_cost(SPRINT_STAMINA * delta)
				else:
					$AnimationPlayer.play("Run")
					if recovery_timer <= 0:
						stamina += STAMINA_RECOVERY * delta
					else:
						recovery_timer -= 1 * delta
			else:
				$mesoman1/mesoman1_Reference/Skeleton3D/BoneAttachment3D/copper_axe/Area3D/CollisionShape3D.disabled = true
				if fighting == 1:
					$AnimationPlayer.play("Fight Idle")
				else:
					$AnimationPlayer.play("Idle", 0.4)
				if recovery_timer <= 0:
					stamina += STAMINA_RECOVERY * delta
				else:
					recovery_timer -= 1 * delta
		elif is_falling:
			$AnimationPlayer.play("Fall")
			$mesoman1/mesoman1_Reference/Skeleton3D/BoneAttachment3D/copper_axe/Area3D/CollisionShape3D.disabled = true
		elif is_jumping:
			$AnimationPlayer.play("Jump")
			$mesoman1/mesoman1_Reference/Skeleton3D/BoneAttachment3D/copper_axe/Area3D/CollisionShape3D.disabled = true
	
		# Remove built up camera rotation to ensure goober turning is optimal
		if $CameraRoot.rotation.y > PI + Vector3(input_dir.x, 0, input_dir.y).signed_angle_to(Vector3(0,0,-1), Vector3(0, 1, 0)):
			$CameraRoot.rotation.y -= 2*PI
		if $CameraRoot.rotation.y < -PI + Vector3(input_dir.x, 0, input_dir.y).signed_angle_to(Vector3(0,0,-1), Vector3(0, 1, 0)):
			$CameraRoot.rotation.y += 2*PI
		
		
	
		
		
		# Change Player Rotation to match Camera if moving
		if hitstun <= 0:
			self.rotation.y = lerp(self.rotation.y, self.rotation.y + ($CameraRoot.rotation.y - Vector3(input_dir.x, 0, input_dir.y).signed_angle_to(Vector3(0,0,-1), Vector3(0, 1, 0))) * is_running * int(not is_rolling) * int(not is_attacking), TURNING_SPEED)
			$CameraRoot.rotation.y -= ($CameraRoot.rotation.y - Vector3(input_dir.x, 0, input_dir.y).signed_angle_to(Vector3(0,0,-1), Vector3(0, 1, 0)))  * TURNING_SPEED * is_running * int(not is_rolling) * int(not is_attacking)
	
	
		var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y).rotated(Vector3(0, 1, 0), ($CameraRoot.rotation.y * int(not is_rolling)) * int(not is_attacking) + locked_rot * is_rolling)).normalized()
		if direction:
			velocity.x = direction.x * (SPEED + (is_sprinting * SPRINT_SPEED))
			velocity.z = direction.z * (SPEED + (is_sprinting * SPRINT_SPEED))
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)
		
		if stamina >= 100:
			stamina = 100
		elif stamina <= 0:
			stamina = 0
		
		$UI.bar_update(health, stamina)
		
		if health <= 0:
			die()
		move_and_slide()

func _in_dialogue_range():
	in_dia_range = 1

func _left_dialogue_range():
	in_dia_range = 0
	in_dialogue = 0
	$DialogueBox.hide_dialogue()

func _recieve_dialogue(dialogue):
	$DialogueBox.display_text(dialogue)
