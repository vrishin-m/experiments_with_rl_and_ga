import socket

def do_stuff(data: str) -> str:
    return "baked " + data

    

ip = "127.0.0.1"
port = 4242
client_socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

client_socket.sendto("INIT".encode(), (ip, port))



while True:
    data, sender_address = client_socket.recvfrom(1024)
    data = data.decode('utf-8')
    print(data)
    result =do_stuff(data)

    client_socket.sendto(result.encode('utf-8'), sender_address)
 
