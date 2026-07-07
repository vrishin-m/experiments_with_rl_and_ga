extends Marker3D


@export var tank_scene: PackedScene
var server: Node3D
var tank_dict={}	
@export var population_size: int	
var num_dead =0
var next_gen = false


func _ready() -> void:
	server = get_tree().current_scene.get_node("server")
	spawn_tanks()
	
func spawn_tanks():
	#tank num starts from index 0
	var tank_num =0
	for i in range(population_size):
		print("ding")
		var tank = tank_scene.instantiate()
		tank_dict[tank_num]= []
		tank.setup(tank_num)
		tank_num +=1
		tank.add_to_group("tanks")
		tank.position = global_position
		tank.rotation = global_rotation
		get_tree().root.add_child.call_deferred(tank)
			
func update_dict(id, data):
	tank_dict[id]= data
	if data[0] ==0:
		num_dead +=1
	if num_dead >= population_size:
		next_gen = true
		server.next_gen()

func _process(delta: float) -> void:
	if !next_gen:
		server.send_data(tank_dict)
	

	

	
