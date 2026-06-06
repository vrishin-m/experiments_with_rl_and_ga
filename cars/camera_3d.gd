extends Camera3D

@onready var character = get_parent().get_node("camera_controller")
@export var mouse_sensitivity = 0.002
@export var max_pitch = PI / 3
@export var distance = -1
@export var height = 1.5

var pitch = 0.0
var yaw = 0.0
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	elif event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		update_yaw(event.relative.x)
		update_pitch(event.relative.y)
	
	

func update_yaw(relative_x: float):
	yaw -= relative_x * mouse_sensitivity

func update_pitch(relative_y: float):
	pitch -= relative_y * mouse_sensitivity
	pitch = clamp(pitch, -max_pitch, max_pitch)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if character:
		var direction = Vector3(0, 0, 1)
		direction = direction.rotated(Vector3.UP, yaw)
		var right = Vector3.RIGHT.rotated(Vector3.UP, yaw)
		direction = direction.rotated(right, pitch)
		global_position = character.global_position - direction * distance + Vector3(0, height, 0)
		look_at(character.global_position + Vector3(0, height, 0), Vector3.UP)
 
