---
title: "Retro Board Update"
date: 2022-02-19T13:50:20Z
draft: false
series: retro-board
type: post
---

# Retro Board Update
Well after a couple of months of coding ive got about 50% through doing reto-board, major progress has been made, it is now techniclly possible to sign up for it,  

you can't yet make any boards, but there an [example](https://retro-board.it/example) version of what a board will look like non of the functionality works in the [example](https://retro-board.it/example)

it took quite a while for me to get the login to work, and the main reason to that is undocumented bits that I had to get working myself, for example "can I do this / userAllowed" is not a standard feature it seems 
at least not in the golang libraries for keycloak, so I had to go down a very long and winding path

## Features that exist
At the moment, you can login, the first person to login with a google-suite account (only google-suite works at the moment)

Once logged in, the first person who logs in can
 - create a company, that company will then allow anyone using the domain/google-suite to be part of that same company
 - create a subdomain, this is more of a visual and linking purpose, it doesn't auto filter on the subdomain for a matching domain in your company, that done through keycloak  
   This was done using kubernetes ingress, which is not as simple as you might hope, but a lot easier than messing with nginx directly

The subdomain part was pretty tricky, I had to learn some more kubernetes stuff, but that allows me to progress with another project that I have in the works but thats news for later

## Features being worked on
- Board creation
- Role assignment, at the moment the first person gets a "Owner" status, and everyone else gets "User" status, but that will be changable later
- Creation of the board items
- Timer creation

---
### Future features
- Github login integration to work out which github organisation you are part of
- Microsoft login integration
- Other Keycloak compatible login integrations
