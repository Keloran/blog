---
title: "Retro Board"
date: 2021-12-06T15:31:36Z
draft: false
series: retro-board
type: project_current
tags: [
	retro-board,
	projects,
  chewedfeed
]
---

# Retro Board
Well I've started another project, retro-board.it this is just going to be a very simple app, that has a couple of options

### Initial Signin
1. Ask the user what the Company name is, this is to create a subdomain with that company name (if it doesnt already exist)
	- if the company name already exists then enter the password for the domain
2. Ask the user for a Team name
3. Ask if they would like to use single sign-on (Google | Github) or accounts

### Team Board Setup
The team board starts with the following options

1. A table with the following headers
	- Good | Bad | Continue
	- they can change these to something else
2. How many votes per column per person are allowed 
	- default: 3 votes per person, per column
3. How long topic creation should be 
	- default: 5min
4. How long topic discussions should be 
	- default: 5min
5. Sprint Leader
	- default: dictated at setup
	- can be chosen at "new retro"

### Initial Usage
- Sprint leader starts the board once everyone has logged in, everyone can create topics 
	- topics are hidden from each other to stop influence of topic discussion,
- if the sprint leader presses the stop button, or the timer runs out (at 30 seconds a button appears to extend time by 1min) there is an option to finish your ticket if you have one in draft
- after all drafts are finished, the topics are un-hidden and the leader can group the topics
- once the topics have been grouped (if needed to be grouped), leader can press the "start vote button"
- each user then can do the number of votes per column allowed (multiple votes per topic allowed) {you can also remove a vote} 
	- votes are hidden during voting
- when voting timer runs out, or everyone has done their votes (+ 30 seconds to let people change their mind)
- votes are shown and highest voted topics are sorted by highest number
- leader chooses a topic to talk about and timer begins (at 30 seconds a button appears to extends the time by 1min)
- at end of timer, leader has an option to create an action (e.g. better biscuits)
- once all topics have been discussed a tally is made of the topics and a score is given for the sprint, 
	- +1 for continue
	- +2 for good 
	- -1 for bad

### Future Usage
This performs the same as initial the only difference is that before the topic creation can begin, the list of actions from last retro are displayed to see if they have been performed, and if not they are auto rolled into the actions for this retro

---
[Github Site](https://github.com/retro-board)

[Company Site](https://retro-board.it)
