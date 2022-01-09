---
title: "RaspberryPI cluster"
date: 2021-10-14T10:39:53+01:00
draft: false
series: kubernetes
project: raspberrypi
---
Well I made Kubernetes cluster using Raspberry PIs, I largely followed the guide [RasperryPI 4 Cluster](https://rpi4cluster.com)

It has the following features
 - 4 Raspberry Pi 4s, 4Gb RAM
 - 1 Raspberry Pi 3s, 1Gb RAM
 - 1 DualCore x64, 8Gb RAM
 - 1Tb storage distributed over the whole cluster
 - ClusterCTRL, this is so power goes through the backplane rather than having 5 seperate power sources

 Because I'm a madman, I also decided that my spare RaspberryPi2 should be used for Home Assistant, so I did that at the same time


 Things that are using the cluster, well this site for one
