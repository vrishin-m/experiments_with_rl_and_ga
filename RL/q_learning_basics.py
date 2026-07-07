#i will be using Q learning to solve a simple "maze"
#i'll add small rewards within the maze, so that with hyperparameter tuning i can get the right balance of short and long term rewards
import numpy as np
import random
import matplotlib.pyplot as plt

#hyperparameters:
discount = 0.9
randomness = 0.5
epochs = 200

maze = np.array([
    [-1,0,0,0,10],
    [0,0,0,0,0],
    [0,0,-1,-1,-1],
    [0,-1,0,0,-1],
    [0,0,-1,1,1],
    [0,0,0,1,1]
])


#coordinates will be of the form y, x where +y direction is down
#and +x direction is towards right

start_state = [5,1]
terminal_states =[[0, 4]]
q_table = np.zeros(shape=(4,6,5), dtype= float)

#defining actions
#they are defined such that, if the agent if at the right edge and tries to go right, it'll stay right where it is
def right(pos):
    return [pos[0], min(pos[1]+1,4)]

def left(pos):
    return [pos[0], max(pos[1]-1,0)]

def down(pos):
    return [min(pos[0]+1,5), pos[1]]

def up(pos):
    return [max(pos[0]-1,0), pos[1]]

actions = [right, left, down, up]

def get_next_state(state, action):
    return action(state)

def reward(state):
    return maze[state[0]][state[1]]


def bellman(state, action):
    next_state = get_next_state(state, action)
    future_rewards =[]
    for i in range(len(actions)):
        future_rewards.append(q_table[i, next_state[0],next_state[1]])
    max_future = max(future_rewards)

    return reward(next_state) + discount*max_future

def exploration(state):
    action_number = random.randint(0, len(actions)-1)
    action = actions[action_number]
    next_state = get_next_state(state, action)
    q_table[action_number, state[0],state[1]] = bellman(state, action)
    return next_state

def exploitation(state):
    q_values = []
    for i in range(len(actions)):
        q_value = q_table[i, state[0],state[1]]
        q_values.append(q_value)

    max_value = max(q_values)
    new_array =[]
    for i in range(len(q_values)):
        if q_values[i] == max_value:
            new_array.append(i)
    
    index = random.choice(new_array)

    action = actions[index]

    next_state = get_next_state(state, action)
    q_table[index, state[0],state[1]] = bellman(state, action)
    return next_state



current_state = start_state
epochs_array =[]
final_episodes=[]


for epoch in range(epochs):
    if randomness -0.003 >=0:
        randomness -= 0.003
    else:
        randomness =0.0

    epochs_array.append(epoch)
    episode =0
    current_state = start_state
    while True:
        episode+=1
        print("epoch:", epoch, "episode:", episode, "state:", current_state)
        var = random.uniform(0,1)
        if current_state in terminal_states:
            print("DING DING DING", episode)
            final_episodes.append(episode)
            break
        if var < randomness:
            current_state = exploration(current_state)
        else:
            current_state = exploitation(current_state)

plt.plot(epochs_array, final_episodes)
plt.show()