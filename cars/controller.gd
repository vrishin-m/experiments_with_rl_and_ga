extends Marker3D


@export var tank_scene: PackedScene
var server: Node3D
var tank_dict={}	
@export var population_size: int	

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

func _process(delta: float) -> void:
	server.send_data(tank_dict)
	

	
