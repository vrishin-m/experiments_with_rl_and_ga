extends CharacterBody3D

var data =[]
var colliders=[]
var current_checkpoint =0
var frames =0
var controller: Marker3D
var id: int


func _ready() -> void:
	colliders =[$front, $back, $front_left, $front_right, $left, $right]
	controller = get_tree().current_scene.get_node("controller")
	





func _process(delta: float) -> void:
	if !is_on_floor():
		velocity.y -= 60*delta
	frames +=1
	data = [current_checkpoint, frames, is_on_floor()]
	for i in colliders:
		if i.is_colliding():
			data.append((global_position-i.get_collider().global_position).length())
		else:
			data.append(0)
	
	send_data()
	drive(instructions.instructions_dict)
	
	
	print(data)
	
	move_and_slide()
	

func send_data():
	controller.update_dict(id, data)
	
func setup(tank_num):
	id = tank_num
	
		
	


func _on_checkpoint_detector_area_entered(area: Area3D) -> void:
	if area.is_in_group("checkpoints"):
		current_checkpoint = String(area.name)
	elif area.is_in_group("walls"):
		die()


func die():
	data[0]=0
	queue_free()
	

func drive(data):
	for i in data:
		if int(i) == id:
			velocity += transform.basis.x * data[i][0]
			rotate(transform.basis.y, data[i][1])
