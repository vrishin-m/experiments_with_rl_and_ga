extends CharacterBody2D

var thrusts =[]
var frames =0
var num_frames =0
var id: Array
var closest_distance = 1000000000000
var distance =10000000
var planet_position: Vector2

var touched_mars = false
var crashed = false

func setup(thrust_arg: Array, num_frames_arg: int, id_arg: Array):
	thrusts = thrust_arg
	num_frames= num_frames_arg
	id = id_arg
	

func _process(delta: float) -> void:
	if frames<len(thrusts):
		velocity += thrusts[frames]
	frames +=1
	if frames >= num_frames:
		die()
	if planet_position:
		distance = (global_position-planet_position).length()
		if distance < closest_distance:
			closest_distance =distance
	
	rotation = atan(-velocity.y/velocity.x)
	
	
	

		
		
	move_and_slide()

func _ready() -> void:
	#var planet = get_tree().current_scene.get_node("planet")
	#planet_position= planet.global_position
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	var spawner = get_tree().current_scene.get_node("spawner")
	crashed = true
	spawner.get_rocket_fitness(Vector2(10000,10000), id, frames, false, false, crashed)
	queue_free()

	
func die():
	return_position()
	queue_free()
	
	
		
func return_position():
	var spawner = get_tree().current_scene.get_node("spawner")
	var got_closer = false

		
	spawner.get_rocket_fitness(global_position, id, frames, got_closer, touched_mars, crashed)


func _on_area_2d_2_body_entered(body: Node2D) -> void:
	touched_mars=true
	var spawner = get_tree().current_scene.get_node("spawner")
	spawner.get_rocket_fitness(Vector2(0.000001,0.000001), id, frames, true, touched_mars, crashed)
	queue_free()
