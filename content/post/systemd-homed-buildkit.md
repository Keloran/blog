---
title: "Systemd Homed Buildkit"
date: 2022-08-23T14:34:09+01:00
draft: false
series: framework_laptop
type: post
tags: [
	framework,
	nerdctl,
	arch,
	linux
]
---
# Premise
So I decided to switch my home directory to use systemd-homed, now this is a cool system that works with btrfs and does snapshoting built in, this led to a few issues though

# Issue
So because of the way containerd and buildkit use squashfs it can't submount inside the homed directory

# Fix
If you have multiple hdds then this is easier, if not your gonna have to create a directory on your system, doing it where I did it is not a good idea, but I'm not an expert

```
sudo mkdir /builds
sudo chown keloran:keloran builds
ln -s /builds /home/keloran/.local/share/buildkit
```

# Hopefully Fixed
Hopefully you can now build again

