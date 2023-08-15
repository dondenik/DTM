extends Node3D

var num_clips = 0
var third_person_base_pos = Vector3(0, 1, 1)
var first_person_base_pos = Vector3(0, 0.5, 0)
var third_person_spring_length = 1
var first_person_spring_length = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$SpringArm3D.position = third_person_base_pos
	$FirstPersonCamera.position = first_person_base_pos


func _input(event):
	if event is InputEventMouseMotion:
		rotation.y -= event.relative.x * 0.01
		rotation.x -= event.relative.y * 0.01
		rotation.x = clamp(rotation.x,-PI/2.0,PI/2.0)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_3d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	num_clips += 1
	if num_clips == 1:
		first_person_mode()


func _on_area_3d_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	num_clips -= 1
	if num_clips < 1:
		third_person_mode()

func third_person_mode():
	print("third person mode")
	$SpringArm3D/ThirdPersonCamera.make_current()
	
func first_person_mode():
	print("first person mode")
	$FirstPersonCamera.make_current()
