extends CharacterBody3D

var current_speed = 30

var mouse_sensitivity = 0.0015
var max_yaw = PI
var yaw=0.0







func _ready():

	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	elif event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		yaw -= event.relative.x * mouse_sensitivity
		self.rotation.y = yaw

func _physics_process(delta):
	# Add gravity


	# Handle jump


	# Get input direction
	var input_dir = Input.get_vector("left", "right", "front", "back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	# Sprint



	if direction:
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)
		velocity.z = move_toward(velocity.z, 0, current_speed)
	
	#wall jump
	
	
	
	

	move_and_slide()






	




		

	
