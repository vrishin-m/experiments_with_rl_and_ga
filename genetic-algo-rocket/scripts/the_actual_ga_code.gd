extends Marker2D

#controls
@export var population_size: int
@export var mutation_rate: float #this is a percentage
@export var num_frames: int #this is the number of frames each rocket will live before self destructing
@export var num_elites: int #number of elites directly passed to next gen
@export var max_thrust: float 
@export var rocket_scene: PackedScene


#initializing some vars
var planet_position: Vector2
var rockets_dict ={}
var generation =1 
var frames =0
var simulation_running = false
var population =[]
var mars_touches =0
var mars_table =[]
var crashes =0



func _ready() -> void:
	population = generate_initial_population()
	spawn_rockets(population)
	simulation_running = true
	planet_position = %planet.global_position
	$RichTextLabel.text= "GENERATION: " + str(generation)
	$RichTextLabel2.text= "MARS LANDINGS: " + str(mars_touches)
	$RichTextLabel3.text= "ASTEROID CRASHES: " + str(crashes)




func _process(delta: float) -> void:
	if frames > num_frames:
		frames=0
		generation +=1
		mars_table.append(mars_touches)
		mars_touches=0
		crashes=0
		$RichTextLabel.text= "GENERATION: " + str(generation)
		$RichTextLabel2.text= "MARS LANDINGS: " + str(mars_touches)
		$RichTextLabel3.text= "ASTEROID CRASHES: " + str(crashes)
		spawn_rockets(selection())
		if generation == 8:
			if mars_table[-1]-mars_table[-2]+mars_table[-3]-mars_table[-4]<=30:
				print("time for some fun")
				mutation_rate += 60
	else:
		frames +=1
	
	



func generate_initial_population():
	var thrusts_array = []
	for i in range(population_size):
		var thrusts = []
		for j in range(num_frames):
			thrusts.append(Vector2(snapped(randf_range(-max_thrust,max_thrust),0.01),snapped(randf_range(-max_thrust,max_thrust),0.01)))
		thrusts_array.append(thrusts)
		
				
				
	return thrusts_array
	
		
func spawn_rockets(population):
	var rocket_num =0
	for i in population:
		if i:
			var rocket = rocket_scene.instantiate()
			var rocket_id = population[rocket_num]
			rockets_dict[rocket_id]= [rocket,0]
			rocket.setup(i,num_frames, rocket_id)
			rocket_num +=1
			rocket.add_to_group("rockets")
			rocket.global_position = global_position
			rocket.global_rotation = global_rotation
			get_tree().root.add_child.call_deferred(rocket)


func get_rocket_fitness(position: Vector2, id: Array, frames: int, got_closer: bool, touched_mars: bool, crashed: bool):
	var distance = (planet_position - position).length()
	var fitness =0
	fitness = (distance**(-3))*75000000000 - frames*50 + int(touched_mars)*1000000000 - int(crashed)*5000
	if fitness<0:
		fitness=0
	
	rockets_dict[id] = [rockets_dict[id][0], fitness]
	if touched_mars:
		mars_touches +=1
		$RichTextLabel2.text= "MARS LANDINGS: " + str(mars_touches)
	if crashed:
		crashes +=1
		$RichTextLabel3.text= "ASTEROID CRASHES: " + str(crashes)
	

func selection():
	var new_thrusts =[]
	var sorted_keys = rockets_dict.keys()
	sorted_keys.sort_custom(func(a, b): return rockets_dict[a][1] > rockets_dict[b][1])

	new_thrusts.append_array(sorted_keys.slice(0,num_elites))
	for i in range(population_size-num_elites):
		var thrusts1 = roulette_select(rockets_dict)
		var thrusts2 = roulette_select(rockets_dict)
	
		new_thrusts.append(seggs(thrusts1, thrusts2))
	
	return new_thrusts

	
	





func seggs(thrusts1, thrusts2):
	var midpoint = randi_range(1, len(thrusts1)-1)
	return mutation(thrusts1.slice(0,midpoint) + thrusts2.slice(midpoint,-1))

func mutation(thrust):
	for i in range(len(thrust)):
		var temp = randf_range(0,100)
		if temp <= mutation_rate:
			thrust[i] = Vector2(snapped(randf_range(-max_thrust,max_thrust),0.01),snapped(randf_range(-max_thrust,max_thrust),0.01))
	return thrust
		
func roulette_select(rockets_dict):
	var sum_fitnesses=0
	for i in rockets_dict:
		sum_fitnesses+= rockets_dict[i][1]
		
	var pick = randf_range(0, sum_fitnesses)
	var current_sum = 0
	for i in rockets_dict:
		current_sum += rockets_dict[i][1]
		if current_sum >= pick:
			return i
