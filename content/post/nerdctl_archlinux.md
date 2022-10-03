---
title: "NerdCTL on ArchLinux"
date: 2022-04-26T17:41:50+01:00
draft: false
series: framework_laptop
type: post
tags: [
	framework, 
	nerdctl, 
	arch,
	kubernetes,
	linux
]
---

# ArchLinux NerdCTL
Arch is a lot like Slackware and Gentoo, whilst it does have a package manager, you have to know what you want before things work

so NerdCTL has the ability to use buildkit to install stuff on multi-arch but that isn't as easy as you would like and as such there are a few things that need installing to make it work

## Steps
This will need [YAY](https://github.com/Jguer/yay) (well there are others but if you copy paste then its yay)

###### Install
``` yay -S nerdctl kubectl qemu-user-static rootlesskit slirp4netns buildkit ```

##### Setup
``` sudo loginctl enable-linger $(whoami) ```
``` sudo vi /etc/sysctl.d/99-rootless.conf ```
```/etc/sysctl.d/99-rootless.conf

kernel.unprivileged_userns_clone=1
net.ipv4.ping_group_range = 0 2147483647
net.ipv4.ip_unprivileged_port_start=0
```
``` sudo touch /etc/subuid /etc/subgid ```
``` sudo sudo usermod --add-subuids 100000-165535 --add-subgids 100000-165535 $(whoami) ```
 
##### Rootless
``` containerd-rootless-setuptool.sh install && containerd-rootless-setuptool.sh install-buildkit ```  
``` systemctl enable --user --now containerd && systemctl enable --user --now buildkit ```

###### Containerd needs to also be run as root in order to do multi-arch
``` sudo systemctl enable --now containerd ```
``` sudo nerdctl run --privileged --rm tonistiigi/binfmt --install all ```
```/usr/lib/systemd/system/multi-arch.service
[Unit]
Description=MultiArch
After=containerd.service

[Service]
Type=simple
ExecStart=nerdctl run --privileged --rm tonistiigi/binfmt --install all > /dev/null

[Install]
WantedBy=multi-user.target
```
``` sudo systemctl enable --now multi-arch ```

#### Reason
This is mainly for me so I have a backup of the requirements for next time I need to install it
