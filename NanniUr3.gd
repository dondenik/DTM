extends "res://NanniUr2.gd"

signal timer_start

func _ready():
	$AnimationPlayer.play("Thrust Slash")
	$AnimationPlayer.pause()
	$AnimationPlayer.seek(0.0)
	self.body_in_talking_range.connect(player._in_dialogue_range)
	self.body_left_talking_range.connect(player._left_dialogue_range)
	player.request_dialogue.connect(_on_dialogue_request)
	self.return_dialogue_request.connect(player._recieve_dialogue)
	$Sprite3D.texture = $Sprite3D/SubViewport.get_texture()
	self.dialogue = npc_dialogue_options[npc_dialogue_counter]
	$AnimationPlayer.play("Thrust Slash")
	$AnimationPlayer.pause()
	$AnimationPlayer.seek(0.0)

func _physics_process(delta):
	$AnimationPlayer.play("Thrust Slash")
	$AnimationPlayer.pause()
	$AnimationPlayer.seek(0.5)
	
	### PHYSICS BASED MOVEMENT NOT REALLY USED ASIDE FROM GRAVITY
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	if move_along_path:
		$AnimationPlayer.play("Walk")
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var input_dir = Vector2(randf_range(-1,1),randf_range(-1,1))
	var input_dir = Vector2(0, 0)
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	if not move_along_path:
		move_and_slide()
	else:
		get_parent().progress += SPEED * delta
		if get_parent().progress_ratio >= 0.9:
			post_destination_func()

func post_dialogue_func():
	Global.sub_quest = "30"
	Global.main_quest = "Run to Ea Nasir before he leaves"
	$"../CharacterBody3D".ui.quest_update()
	self.npc_dialogue_options = ["Have you spoken to Ea Nasir yet?"]
	if self.get_node("../Ea Nasir").talked_to:
		self.npc_dialogue_options.append("That scoundrel! I will have to pursue this further...")
		$"../CharacterBody3D".screenTrans.change_scene_to_file("res://Ur 3.tscn")
	else:
		self.npc_dialogue_options.append("Go ask Ea Nasir for a refund before he leaves for Babylon!")
	self.npc_dialogue_counter = 0
	self.dialogue = self.npc_dialogue_options[self.npc_dialogue_counter]
	timer_start.emit()
	
