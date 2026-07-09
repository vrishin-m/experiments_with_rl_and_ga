this is a repo where i play around with genetic algos and reinforement learning while i learn.

it's just a bunch of exercises in my learning journey



# what i've built (so far)

### /GA/monke.py

this is a genetic algorithm based program that generates random strings of letters and evolves them to get a given string. it's been called the "hello world of genetic algorithms"
<img width="1407" height="833" alt="image" src="https://github.com/user-attachments/assets/3bff5263-db4d-4847-95ba-1ffc8476dad8" />


### genetic-algo-rocket

i used godot engine to make game agents that learnt to avoid obstacles and move towards a target. each generation, hundreds of rockets are launched. these rockets get random thrusts every single frame. however, eventually they begin learning how to dodge the asteroids and reach planet mars! ignore the shitty graphics, i just used stock images. in the attached video clip, you can see how a couple of rockets in the first (completely random) generation happened to land on mars. they then passed on their genes to the next generations, and even many generations later, you can observe the rockets following their 2 distinct pathways. in other trials, i observed some pathways being preferred over others, and the rockets following one pathway even going "extinct".
<img width="1213" height="681" alt="image" src="https://github.com/user-attachments/assets/09e0a9ab-7cd9-4150-bbd2-ba45a9e2e658" />


### cars

so this one is a project where i evolve the weights of a neural network so that they learn to drive a car! they get inputs from 6 raycasts pointing at various directions, and pass out 2 numbers: an acceleration and a turn in radians.

the final result of this project would have been cool, but i just abandoned it because it felt like too much work without much learning outcomes. by that i mean, i already know about regular NNs and genetic algos. combining both of them is not really going to teach me new things.  maybe i'll finish it off someday using ai.
<img width="1213" height="768" alt="image" src="https://github.com/user-attachments/assets/9d2850a3-de45-41d0-a844-7c9ad2fca040" />


### /RL/q_learning_basics.py

this is a basic maze solver with python! i'm still experimenting with this one.

in this screenshot, you can see the maze i built. the only positive reward is the terminal state (+10). (-1 is just a penalty, not a terminal state).

the plot is episodes taken to reach terminal state vs epochs.

the downward trend is quite clear. the algo clearly learns how to go to the terminal stage in minimum steps
<img width="994" height="586" alt="Screenshot 2026-07-07 214230" src="https://github.com/user-attachments/assets/f136dd0a-94e0-4c29-a6a5-a7b8d49397e2" />




this screenshot is quite interesting. if you notice the bottom right of the maze, you can see that i've set a "trap"
<img width="246" height="216" alt="image" src="https://github.com/user-attachments/assets/78692270-f156-410d-94be-aced3e062758" />

i call it "doomscrolling". the agent spent THREE MILLION episodes just doomscrolling on the little rewards (the 1s). honestly, it seemed like it wud never reach the big reward! i will try to play with the discount, greed and other hyperparameters to try and curb this behaviour. but for now, my agent just won't stop doomscrolling and doesn't care about the big picture (perhaps he is taking some notes from his creator)

<img width="545" height="940" alt="Screenshot 2026-07-07 214825" src="https://github.com/user-attachments/assets/e5711280-66ae-4460-969d-fe67b6b6ebf4" />

# UPDATE!

I have solved doomscrolling!

the solution is as counterintuitive as it gets. 

<img width="1202" height="881" alt="Screenshot 2026-07-09 110121" src="https://github.com/user-attachments/assets/62610383-a163-4713-ba14-7ccb836931ce" />
this screenshot shows the maze, and the infinite loop created. the array with the alphabets is the best action according to the Q-Table. as you can see, the agent learns that the "best" solution is to go back and forth in an infinite loop between the two 1s

<img width="1302" height="844" alt="Screenshot 2026-07-09 110201" src="https://github.com/user-attachments/assets/a91bdeb1-f9a5-4b71-8fd7-40ac1624b58a" />

this screenshot shows the solution!! i REDUCED the disount factor, so that the agent chases immediate rewards rather than future rewards. and this actually ended up pointing it to the big 100, rather than discovering infinite loops and other cheats!!

### demo videos

note: the videos are in real time, so they're pretty boring. maybe play subway surfers or something and watch these videos

text:

https://drive.google.com/file/d/1FEFGQHNgBD-wNPc6U0pj6pHfJqdaJI9w


game:

https://drive.google.com/file/d/13p-PJCFZVoBXtligPRaDw422aAiwAH5M


here's an experiment i did. in this clip, the rockets were given huge incentive to reach mars (the target). hitting asteroids gave them a penalty, but the reward of landing on mars were higher. so, while the number of mars landings increased steadily, the number of asteroid crashes kept fluctuating and showed no particular trend

game clip 2:

https://drive.google.com/file/d/1DWBy2Dpxj1FEiV45h9nigvbWwcYW-7TJ

in this clip, i removed mars altogether, and created a small "asteroid free zone" to the left side of the screen. and as expected, the rockets learnt to avoid asteroids and stick to the left side, with each generation having less losses!

game clip 3:

https://drive.google.com/file/d/1bsUW8TdpH9sWx81-aoMSKC3ik0tF9fph

another experiment! this is the same as clip 2, except i added the asteroids back to the left side, making their distribution somewhat uniform again. the rockets seemed to have learnt to just stick to the spawn area, with a few outliers weaving through the asteroids and passing on their genes too! the most surprising part to me is that even though this time there was no obvious solution (unlike last time, where "go left" was basically a cheat code to survival), the rockets still improved every generation!

