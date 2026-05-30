#using GA's to train a monke to type "banana"
import random
import string


key_set = list(string.ascii_lowercase)
key_set.append('_')
generations =0


#controls to modify!
target_word = "this_is_a_random_string"
population_size = 4500
mutation_rate = 8 #this is a percentage
num_elites = 50 #this is the number of top candidates from each generation who directly make it to the next one 
                #without undergoing reproduction


def fitness(current_word):
    score =0
    for i in range(len(target_word)):
        if target_word[i] == current_word[i]:
            score +=1
    
    return score**2


def generate_population():
    word_length = len(target_word)
    population =[]
    for i in range(population_size):
        word =''
        for j in range(word_length):
            word += random.choice(key_set)
        population.append(word)
    return(population)


def seggs(word1, word2):
    midpoint = random.randint(1, len(word1)-1)
    return mutation(word1[:midpoint] + word2[midpoint:])



def mutation(word):
    new_word=list(word)
    for i in range(len(word)):
        random_var = random.randint(0,100)
        if random_var <= mutation_rate:
            new_word= new_word[:i] + [random.choice(key_set)] + new_word[i+1:]
    return ''.join(new_word)



def selection(population):
    fitness_dict =dict.fromkeys(population,0)
    sum_fitnesses =0
    for i in fitness_dict:
        fitness_i = fitness(i)
        fitness_dict[i] = fitness_i
        sum_fitnesses+= fitness_i
  
    
    new_population =[]
    sorted_dict = dict(sorted(fitness_dict.items(), key=lambda item: item[1], reverse=True))

    for i in range(num_elites):
        new_population.append(list(sorted_dict.keys())[i])
    
    top_result = new_population[0]
    
    for j in range(population_size - num_elites):
        parent1 = roulette_select(fitness_dict, sum_fitnesses)
        parent2 = roulette_select(fitness_dict, sum_fitnesses)
        child = seggs(parent1,parent2)
        new_population.append(child)
    
    
    return new_population, top_result


    
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


while top_result != target_word:
    generations +=1
    population, top_result = selection(population)
    print("GENERATION: ", generations, "\n TOP RESULT: ", top_result, "\n ____________________________________")








    
    
        
        



