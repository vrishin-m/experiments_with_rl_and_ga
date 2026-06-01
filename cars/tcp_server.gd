extends Node

var server: UDPServer
var active_peer: PacketPeerUDP = null
var python_pid: int

func _ready() -> void:
	server = UDPServer.new()
	server.listen(4242)
	print("godot server listening on port 4242...")
	launch_python_script()

func _process(_delta: float) -> void:
	server.poll()

	if server.is_connection_available():
		active_peer = server.take_connection()
		active_peer.get_packet() 
		print("python client connected")

	if active_peer != null:
		if active_peer.get_available_packet_count() > 0:
			var packet = active_peer.get_packet()
			var data = packet.get_string_from_utf8()
			print("received from python: ", data)
		
		var input = "potato"
		active_peer.put_packet(input.to_utf8_buffer())



func launch_python_script() -> void:
	var script_path = ProjectSettings.globalize_path("res://python_stuff/comms.py")
	var args = [script_path]

	var output = OS.create_process("python", args)
	
	if output > 0:
		python_pid = output
		print("PID: ", python_pid)
	else:
		print("failed to launch python")
