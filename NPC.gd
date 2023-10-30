extends CharacterBody3D
class_name npc

signal body_in_talking_range
signal body_left_talking_range
signal return_dialogue_request(dialogue)

var dialogue = "Greetings"

var npc_dialogue_options = []
var npc_dialogue_mode = "sequential"

@onready var player = get_parent().get_node("CharacterBody3D")

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	self.body_in_talking_range.connect(player._in_dialogue_range)
	self.body_left_talking_range.connect(player._left_dialogue_range)
	player.request_dialogue.connect(_on_dialogue_request)
	self.return_dialogue_request.connect(player._recieve_dialogue)
	$Sprite3D.texture = $Sprite3D/SubViewport.get_texture()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

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

	move_and_slide()


func _on_talking_hitbox_body_entered(body):
	body_in_talking_range.emit()
	$Sprite3D.show()



func _on_talking_hitbox_body_exited(body):
	body_left_talking_range.emit()
	$Sprite3D.hide()


func _on_dialogue_request():
	return_dialogue_request.emit(self.dialogue)