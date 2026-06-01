import socket
import json


ip = "127.0.0.1"
port = 4242
client_socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)


client_socket.sendto("INIT".encode(), (ip, port))
print("server running")


while True:
    data, sender_address = client_socket.recvfrom(1024)
    decoded_msg = data.decode('utf-8')
    
        
    try:

        godot_json = json.loads(decoded_msg)
        godot_fps = godot_json.get("fps", 0)

        
    except json.JSONDecodeError:
        print("invalid json")
        continue

    python_response = {
        0: [3,0],
        1: [5,0.1],
        2: [0,0.5]
 

    }
    
    json_string = json.dumps(python_response)
    client_socket.sendto(json_string.encode('utf-8'), sender_address)

