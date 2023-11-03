extends CharacterBody3D

@export var SPEED = 4
const JUMP_VELOCITY = 4.5
const TURNING_SPEED = 5.0
@export var ATTACK_COOLDOWN = 2
@export var ATTACK_TIME = 1.5
@export var AGGRO_DIST = 3
@export var ATK_SPEED = 0.85
@export var HIT_STUN = 1.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var health = 10
var dead = false
var attack_cooldown = 0
var attack_timer = 0
var aggro = 0
var iframes = 0
var hitstun = 0




func _ready():
	$Sprite3D.texture = $Sprite3D/SubViewport.get_texture()
	$Sprite3D/SubViewport/Health.value = 100 - health
	$mesoman1/mesoman1_Reference/Skeleton3D/BoneAttachment3D/copper_axe/Area3D/CollisionShape3D.disabled = true
	extension_func()

func die():
	$AnimationPlayer.play("Die")
	$Sprite3D.hide()
	dead = true
	$CollisionShape3D.disabled = true
	$mesoman1/mesoman1_Reference/Skeleton3D/BoneAttachment3D/copper_axe/Area3D/CollisionShape3D.disabled = true



func _physics_process(delta):
	if not dead:
		# Add the gravity.
		if not is_on_floor():
			velocity.y -= gravity * delta
	
		var player_position = get_parent().get_node("CharacterBody3D").position
		var target_vector = global_position.direction_to(player_position)
		var target_basis = Basis.looking_at(target_vector)
		var is_attacking = int(attack_timer > 0)
		target_basis = target_basis.get_rotation_quaternion()
		target_basis.x = 0
		target_basis.z = 0
		basis = basis.slerp(target_basis, TURNING_SPEED * delta).get_rotation_quaternion()
	
		# check if near player:
		var distance_to_player = self.global_position.distance_to(player_position)
	
		# input_dir, (0, -1) = towards player
		var input_dir = Vector2(0, -1) * int(not (distance_to_player < 1.2)) * int(not is_attacking) * aggro
	
		var is_running = int((abs(input_dir.x) or abs(input_dir.y)))
		
		
	
	
		
		attack_cooldown -= 1 * delta
		attack_timer -= 1 * delta
	
		iframes -= (1 * delta)
		iframes = iframes * int(iframes > 0)
		
		hitstun -= (1 * delta)
		hitstun = hitstun * int(hitstun > 0)
		
		if health <= 0:
			die()
			$mesoman1/mesoman1_Reference/Skeleton3D/BoneAttachment3D/copper_axe/Area3D/CollisionShape3D.disabled = true
		
		
		else:
			if aggro == 0:
				$AnimationPlayer.play("Idle")
				if distance_to_player < AGGRO_DIST:
					aggro = 1
			
		
			if hitstun > 0:
				$AnimationPlayer.play("Armature|mixamo_com|Layer0_015 Retarget")
				$mesoman1/mesoman1_Reference/Skeleton3D/BoneAttachment3D/copper_axe/Area3D/CollisionShape3D.disabled = true
				input_dir = Vector2(0,0)
			elif distance_to_player < 1.2:
				if attack_cooldown <= 0 and not is_attacking and aggro == 1:
					$AnimationPlayer.play("Slash", -1, ATK_SPEED)
					#$AudioStreamPlayer3D.play()
					attack_cooldown = ATTACK_COOLDOWN
					attack_timer = ATTACK_TIME
				else:
					$AnimationPlayer.queue("Fight Idle")
			elif is_running:
				$mesoman1/mesoman1_Reference/Skeleton3D/BoneAttachment3D/copper_axe/Area3D/CollisionShape3D.disabled = true
				$AnimationPlayer.play("Run")

			var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
			if direction:
				velocity.x = direction.x * SPEED
				velocity.z = direction.z * SPEED
			else:
				velocity.x = move_toward(velocity.x, 0, SPEED)
				velocity.z = move_toward(velocity.z, 0, SPEED)
		
			move_and_slide()


func _on_area_3d_area_entered(area):
	if iframes <= 0:
		health -= 10
		iframes = HIT_STUN
		hitstun = HIT_STUN
		set_deferred("$mesoman1/mesoman1_Reference/Skeleton3D/BoneAttachment3D/copper_axe/Area3D/CollisionShape3D.disabled", true)
		$Sprite3D/SubViewport/Health.value = 100 - health

func extension_func():
	pass
