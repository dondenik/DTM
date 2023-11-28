extends "res://NPC.gd"

var enemy = load("res://thiefEnemy.tscn")

func post_dialogue_func():
	Global.sub_quest = "Recover the money from the thief"
	$"../../../CharacterBody3D".ui.quest_update()
	await timer(0.5)
	self.rotation = Vector3(0,0,0)
	get_parent().get_parent().rotation = Vector3(0,0,0)
	self.move_along_path = true
	
	# make it so the boat man wont take me to Babylon
	
	self.get_node("../../../Raft Guy").has_money = false

func post_destination_func():
	self.move_along_path = false
	var thief = enemy.instantiate()
	self.hide()
	thief.position = self.global_position
	self.get_node("../../../../UrRoot").add_child(thief)
	self.queue_free()

func timer(seconds):
	await get_tree().create_timer(seconds).timeout

func _physics_process(delta):
	
	### PHYSICS BASED MOVEMENT NOT REALLY USED ASIDE FROM GRAVITY
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	if move_along_path:
		$AnimationPlayer.play("Run")
	else:
		$AnimationPlayer.play("Idle")
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
