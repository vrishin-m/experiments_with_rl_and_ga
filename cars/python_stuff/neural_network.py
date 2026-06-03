import torch

max_acc=1
max_angle =0.05

def final_result(data):
    pass


def fitness(data):
    return (data[0]**4)*100 - data[1]**2 - data[2] 

#separate neural networks for each tank. weights are updated every frame with gradient descent. so every frame 
#there is a forward pass and a backward pass. then, at the end of each iteration, we breed the top performers so
#that the weights are updated by genetics as well