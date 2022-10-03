---
title: "Mistakes Were Made"
date: 2022-03-14T22:12:30Z
draft: false
series: kubernetes
type: post
tags: [
	kubernetes
]
---

# Mistakes were made
Well I've had a fun weekend, on one side I "finally" caught covid and as such my concentration levels were very low, now that doesn't make up for what I did but at least I have 1/2 an out  

### What happened
I decided to do a little cleaning up of my kubernetes cluster, and decided that I should remove some deployments that weren't in use, that was going fine, but then I decided to try and move some of the things that were more "central" to their correct namespace,  
`correct is a probably the wrong word, since I do kind of follow the principle of a namespace for a service rather than a namespace for a project (e.g. all of chewedfeed's stuff goes in the chewedfeed one, some things should be seperate if they are used by multiple things)`

Which is where it went wrong, I have/had a habit of including ```kind: Namespace``` in my manifests now this can be a good idea, but I tried out a deployment, and switched it to use my ```namespace: chewedfeed``` which wouldn't be an issue if I hadn't then run ```kubectl delete -f manifest.yml``` which included the namespace-kind  

And up in smoke went the chewedfeed namespace, which also took out the PVCs, which included the one for Keycloak, which has a few undocumented "features" one of which is that getting integration in Go is not the easiest thing

### Leasons Learnt
Don't include ```kind: Namespace``` in my manifests and make that a separate manifest so it's harder to delete a namespace in the future

---

Because I wiped out my keycloak instance, I decided it would be a good idea to update to v17, this is proving even harder to integrate with Go, but thats because the undocumented features defenatlly don't work on this version  


So now I am in the process of spending time trying to get v17 to work with Go, and see if I can get retro-board back on track