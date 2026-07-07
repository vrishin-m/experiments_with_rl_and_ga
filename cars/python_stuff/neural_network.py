import torch
from torch import nn
import random



num_tanks=50
max_acc=0.3
max_angle =0.007
generations =1
mutation_rate = 5 
num_elites = 5


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
            nn.Linear(10, 20),
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
#this is cumulative over the entire run
len_fitness = len(fitness)
models =  [NeuralNetwork(model_number=i) for i in range(num_tanks)]





def final_result(data):
    global fitness
    print("INPUT DATA", data)
    output =  {int(i): models[int(i)](torch.tensor(data[i])).tolist() for i in data}
    print("OUTPUTS", output)
    new_fitness = [fitness_func(data[str(i)]) for i in range(len_fitness)]
    fitness = [fitness[i] + new_fitness[i] for i in range(len_fitness)]
    return output




def fitness_func(tank):
    return (tank[1]**4)*100 - tank[2]**2 - tank[3] + tank[0]*100


def selection():
    generations+=1
    weights = [i.state_dict().values() for i in models]
    fitness_dict = dict(zip(weights,fitness))
    sum_fitnesses = sum(fitness)
    
  
    
    new_population =[]
    sorted_dict = dict(sorted(fitness_dict.items(), key=lambda item: item[1], reverse=True))

    for i in range(num_elites):
        new_population.append(list(sorted_dict.keys())[i])
    
    top_result = new_population[0]
    
    for j in range(num_tanks - num_elites):
        parent1 = roulette_select(fitness_dict, sum_fitnesses)
        parent2 = roulette_select(fitness_dict, sum_fitnesses)
        child = seggs(parent1,parent2)
        new_population.append(child)
    
    
    return new_population, top_result




def seggs(tank1, tank2):
    midpoint = random.randint(1, len(tank1)-1)
    return mutation(tank1[:midpoint] + tank2[midpoint:])



def mutation(tank):
    for i in range(len(tank)):
        random_var = random.randrange(0,100)
        if random_var <= mutation_rate:
            tank= tank[:i] + [random.randrange(-100.0,100.0)] + tank[i+1:]
    return tank




   


    
def roulette_select(fitness_dict, sum_fitnesses):
    pick = random.uniform(0, sum_fitnesses)
    current_sum = 0
    for i in fitness_dict:
        current_sum += fitness_dict[i]
        if current_sum >= pick:
            return i

    return random.choice(list(fitness_dict.keys()))



#MAIN LOOP

population, top_result = selection(generate_population())


while top_result != target_tank:
    generations +=1
    population, top_result = selection(population)
    print("GENERATION: ", generations, "\n TOP RESULT: ", top_result, "\n ____________________________________")








    
    
        
        




