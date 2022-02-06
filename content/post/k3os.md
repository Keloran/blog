---
title: "K3OS"
date: 2022-02-06T17:52:44Z
draft: false
series: none
type: post
---

# K3OS
K3OS is kinda self explanitory if you know what K3s is, if not then [k3OS](https://k3os.io) is Rancher's [k3s](https://k3s.io) which is a kubernetes compatible version but a lot smaller

## Why did I tell you that
Well now that bit is out of the way, I upgraded ubuntu on one of my raspberry pi 3's, and at the same time upgraded k3s to the latest version, and that pi became almost impossible to use with kubernetes, pods failing all the time,
since I needed to wipe it anyway, and possibly replace with a pi4 (which are harder to find than rocking-horse-{redacted}) why not give k3os a shot, this is where the fun began

## Documentation
So the documentation for k3os isnt the best, its a beta os for a reason, so I didn't expect the docs to be perfect, but I kinda wanted some instructions, hehe
Time to go looking for a guide on the web, and a [guide](https://www.chriswoolum.dev/k3s-cluster-on-raspberry-pi) I found but slightly out of date at this point, it pointed to a project that can build in image easily
Unfortunately it was also out of date, so I have [forked](https://github.com/Keloran/picl-k3os-image-generator) it and done some slight changes

### Changes I have added
The only real changes I made are updating the base images and adding a latest option for K3OS_VERSION

## So whats it like
Well it performs a lot better than ubuntu, the biggest issue is that it doesn't appear to have a few things that I would prefer to be there, those can be added by altering the base image, one of the things ive added to the script, 
but haven't tested yet is rsyslog, if that does work (I'll test it when I create my 2nd set of pi's for the cluster, using k3os rather than ubuntu) excellent

The other "big" issue is that there doesn't appear to be a way of setting an IP address, now that shouldn't really matter, since my local DNS server can just point at it, but I would prefer to have an option of giving it a fixed IP 
