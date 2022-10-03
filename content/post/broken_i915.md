---
title: "Broken i915"
date: 2022-10-03T15:08:21+01:00
draft: false
series: framework_laptop
type: post
tags: [
	linux,
	framework
]
---

# Well that was annoying
So I run arch on my framework, and because I'm slightly an idiot I didn't have linux/linux-headers in the do not upgrade filter, now thats a lesson I won't forget soon

I did the standard upgrade, which brought with it the latest (5.9.12) kernel with it, wish I remembered it did that, because when I rebooted, my display no longer worked, and once it got to sway, and didn't initiate the eGPU, my FPS on sway was about 0.000005 so impossible to do anything

Now I thought oh, I've been messing with sway configs, and eGPU settings since I last rebooted, it's prob me being an idiot so ill SSH in, and then delete the sway config, and see if that fixes it **NOPE**, awesome, guess it's something else

## A journey of pain
Decided it was prob a good idea to flash my machine, meant I could go back to ext4 and not use systemd-homed (which caused other issues see previous posts)

booted into the latest live version of endevour and it works, cool, ill flash

rebooted and nope display no longer works, WTF

okay maybe its because its because I did a connected install and it grabbed a version of the GPU driver that was bad, **NOPE**

now to spend the next 16h not thinking its the kernel thats broken, I mean i915 is on every single intel cpu (that has built in graphics) they cant have broken it for that, I mean thats got so much test coverage and the patches for i915 are actually made my intel themselves

## The kernel is fucked
So fine i'll see what version of kernel is on the live version, 5.9.6, okay what version is installed when I do an install 5.9.12

time to look at the changelog, and 5.9.12 had a change in the i915 module, right lets see what happens if I install and then force downgrade in chroot to 5.9.11

```
sudo pacman -U https://archive.archlinux.org/packages/l/linux/linux-5.19.11.arch1-1-x86_64.pkg.tar.zst
sudo pacman -U https://archive.archlinux.org/packages/l/linux-headers/linux-headers-5.19.11.arch1-1-x86_64.pkg.tar.zst
```

*HALLELUJAHj*

it works

Guess I won't be upgrading to kernel 6 that released today unless they have reverted that patch

#### Add linux/linux-headers to ignore
Update the line in ```/etc/pacman.conf```

``` IgnorePkg   = linux-headers linux ```