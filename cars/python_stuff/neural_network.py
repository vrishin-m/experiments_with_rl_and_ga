import torch
from torch import nn
import time

num_tanks=30
max_acc=0.3
max_angle =0.02


def change_num_tanks(n):
    global num_tanks
    num_tanks=n
    print(num_tanks, "FUREGJKENJK")

#separate neural networks for each tank. weights are updated every frame with gradient descent. so every frame 
#there is a forward pass and a backward pass. then, at the end of each iteration, we breed the top performers so
#that the weights are updated by genetics as well


class NeuralNetwork(nn.Module):
    def __init__(self, model_number):
        super().__init__()
        self.model_number = model_number
        self.linear_relu_stack = nn.Sequential(
            nn.Linear(9, 20),
            nn.ReLU(),
            nn.Linear(20, 20),
            nn.ReLU(),
            nn.Linear(20, 2),
        )

    def forward(self, x):
        logits = self.linear_relu_stack(x)
        if logits[0]>max_acc:
            logits[0]=max_acc
        elif logits[0]<-max_acc:
            logits[0]=-max_acc

        if logits[1]>max_angle:
            logits[1]=max_angle
        elif logits[1]<-max_angle:
            logits[1]=-max_angle
        
        return logits



fitness = [0 for i in range(num_tanks)]
len_fitness = len(fitness)
models =  [NeuralNetwork(model_number=i) for i in range(num_tanks)]





def final_result(data):
    global fitness
    print("INPUT DATA", data)
    output =  {int(i): models[int(i)](torch.tensor(data[i])).tolist() for i in data}
    print("OUTPUTS", output)
    new_fitness = [fitness_func(data[str(i)]) if data[str(i)] else -1000 for i in range(len_fitness)]
    fitness = [fitness[i] + new_fitness[i] for i in range(len_fitness)]
    return output




def fitness_func(tank):
    return (tank[0]**4)*100 - tank[1]**2 - tank[2] 