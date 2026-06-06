import socket
import json
import time 
import neural_network


ip = "127.0.0.1"
port = 4242
client_socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
max_frames = 2000
num_tanks = 30
neural_network.change_num_tanks(num_tanks)


time.sleep(1) 


client_socket.sendto("INIT".encode(), (ip, port))
print("Python JSON worker running...")




while True:
    try:
        data, sender_address = client_socket.recvfrom(65535)
        decoded_msg = data.decode('utf-8')
        
        if decoded_msg == "INIT":
            continue
            
        godot_dict = json.loads(decoded_msg)
        python_response = neural_network.final_result(godot_dict)
        if godot_dict["0"][2] >= max_frames:
            break
        json_string = json.dumps(python_response)
        client_socket.sendto(json_string.encode('utf-8'), sender_address)

    except ConnectionResetError:

        print("godot not available")
        time.sleep(0.5)
        client_socket.sendto("INIT".encode(), (ip, port)) 
        
    except json.JSONDecodeError:
        print("invalid data from godot")
        continue


