this is a repo where i play around with genetic algos and reinforement learning while i learn.

it's just a bunch of exercises in my learning journey



# what i've built (so far)

### /GA/monke.py

this is a genetic algorithm based program that generates random strings of letters and evolves them to get a given string. it's been called the "hello world of genetic algorithms"


### genetic-algo-rocket

i used godot engine to make game agents that learnt to avoid obstacles and move towards a target. each generation, hundreds of rockets are launched. these rockets get random thrusts every single frame. however, eventually they begin learning how to dodge the asteroids and reach planet mars! ignore the shitty graphics, i just used stock images. in the attached video clip, you can see how a couple of rockets in the first (completely random) generation happened to land on mars. they then passed on their genes to the next generations, and even many generations later, you can observe the rockets following their 2 distinct pathways. in other trials, i observed some pathways being preferred over others, and the rockets following one pathway even going "extinct".


### demo videos

note: the videos are in real time, so they're pretty boring. maybe play subway surfers or something and watch these videos

text:

https://drive.google.com/file/d/1FEFGQHNgBD-wNPc6U0pj6pHfJqdaJI9w


game:

https://drive.google.com/file/d/13p-PJCFZVoBXtligPRaDw422aAiwAH5M


game clip 2:

https://drive.google.com/file/d/1DWBy2Dpxj1FEiV45h9nigvbWwcYW-7TJ

here's an experiment i did. in the first clip, the rockets were given huge incentive to reach mars (the target). hitting asteroids gave them a penalty, but the reward of landing on mars were higher. so, while the number of mars landings increased steadily, the number of asteroid crashes kept fluctuating and showed no particular trend. in this clip, i removed mars altogether, and created a small "asteroid free zone" to the left side of the screen. and as expected, the rockets learnt to avoid asteroids and stick to the left side, with each generation having less losses!

game clip 3:

https://drive.google.com/file/d/1bsUW8TdpH9sWx81-aoMSKC3ik0tF9fph

another experiment! this is the same as clip 2, except i added the asteroids back to the left side, making their distribution somewhat uniform again. the rockets seemed to have learnt to just stick to the spawn area, with a few outliers weaving through the asteroids and passing on their genes too! the most surprising part to me is that even though this time there was no obvious solution (unlike last time, where "go left" was basically a cheat code to survival), the rockets still improved every generation!

