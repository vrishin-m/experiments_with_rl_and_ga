extends CharacterBody3D

var data =[]
var colliders=[]
var current_checkpoint =0
var frames =0
var controller: Marker3D
var id: int
var max_speed = 10

var max_frames: int

func _ready() -> void:
	print("dong")
	colliders =[$front, $back, $front_left, $front_right, $left, $right]
	controller = get_tree().current_scene.get_node("controller")
	max_frames= instructions.max_frames
	





func _process(delta: float) -> void:

	frames +=1
	if frames >= max_frames:
		send_data()
		queue_free()
		
	var next_checkpoint = get_tree().current_scene.get_node(str(current_checkpoint+1)).global_position
	data = [current_checkpoint, (global_position-next_checkpoint).length(), frames]
	for i in colliders:
		if i.is_colliding():
			data.append((global_position-i.get_collider().global_position).length())
		else:
			data.append(0)
	send_data()
	drive(instructions.instructions_dict)
	
	if velocity.length()>max_speed:
		velocity = max_speed*transform.basis.x
		
	
	
	print(data)
	
	move_and_slide()
	

func send_data():
	controller.update_dict(id, data)
	
func setup(tank_num):
	id = tank_num
	print("DING DONG")
	
		
	


func _on_checkpoint_detector_area_entered(area: Area3D) -> void:
	if area.is_in_group("checkpoints"):
		current_checkpoint = String(area.name)
	



func die():
	data[0]=0
	queue_free()
	

func drive(data):
	for i in data:
		if int(i) == id:
			velocity += transform.basis.x * data[i][0]
			rotate(transform.basis.y, data[i][1])


func _on_checkpoint_detector_body_entered(body: Node3D) -> void:	
	if body.is_in_group("walls"):
		print("ow")
		die()
