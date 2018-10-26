I cannot remember exactly what the logic to this program was but here was the general idea. 

There is a old Nintendo64 game called "Super Mario 64". The goal of the game was to play Mario in a 3D world and collect enough Stars to challenge Bowser at the end and win the game. Multiple stars are hidden away across multiple levels. There are a total of 120 stars but you do not need all 120 to win the game.

A group of people began playing the game and "Speedrunning" it. This meant accomplish a certain goal in under a specific amount of time. Popular speedruns for "Super Mario 64" include the 16 Star, 70 Star, and 120 Star runs. 

Speedrunners attempt to always improve their time and get ever closer to whoever is currently the fastest at the game. To this extent they will optimize specific parts of the game (Say 1 level) and get a pattern down that may or may not be unique to them, but they can do consistantly. Shaving off even a few seconds per level can amount to a new highscore, so every frame of the game counts. 

This was an attempt to find out where speedrunners were lacking, which I made at the request of my friend Brandon. It looks at the most popular website with SM64 speedruns, splits.io, which is a website where speedrunners upload their scores and times. 
Speedrunners also record their time thoughout the game at various checkpoints (splits), where they can see if they are ahead or behind their time, and if they should continue the run or if they lost too much time prior to justify continuing as they probably will not set a new high score. 

My program makes use of that and grabs all of these times and then can categorize the averages. 

Here is the use:
	I speed run "Super Mario 64"
	I have an average best time. 
	I would like to improve
	I can run this program to get the data and then specify a range around my time. 
	This program will then average all of the times within that range and get the specific time between checkpoints, and it's average.
	I can look at this and see that for players around my skill level, they tend to score 10 seconds faster on average on checkpoint (Split) D, whereas my best is faster than my skill group average at checkpoint (Split) B. 
	Because of this I know my time for point B is good, and I should focus on training on time D, as cutting that time down would move me into a new skill bracket. 

The only issues with this is that not all people start and stop their checkpoints in the same place or do them in the same order. 
	For example some people might do checkpoint A then checkpoint C while most people go from A to B. 
	Likewise with this game people generally "Split" and make a checkpoint of their time after they complete one level and get all the stars hidden within that level. 
	Some people will only get half the stars from a level, split, and move on. 
	I attempted to rectify this and there could be more done to ensure times are not getting crossed, but for it's purpose it will suffice, the edge cases are a minority. 