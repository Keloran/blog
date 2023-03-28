---
title: "Cluster Update"
date: 2023-03-28T11:21:05+01:00
draft: true
series: kubernetes
type: post
tags: [
	kubernetes
]
---

# Cluster Update
My kubernetes cluster runs on a mix of RaspberryPI 4s, and x86(AMD64) machines, but because I built it originally with only the raspberrys, my control plane was on a PI

Well that was working fine for nearly 2 years, but the SD card on the control plane died, which wasn't a good time

So I decided to what I always do, and go nuts

## Spending spree
So I purchased a few things to tackle this issue

- DL360g8
	- This is a server that is slightly overkill, it has 24 cores (2x Xeon E5-2420), and currently 32Gb of RAM (128Gb on order)
- R715
	- If the last one was overkill, it has 32cores (2x Opteron 6200), and currently 32Gb of RAM (128Gb on order)
- DL160g6
	- This server is mainly used as a database runner, it has 16 cores (2x Xeon L5630), and has 96Gb of RAM
- EX2200-48p-4g
	- This is a fully managed POE switch, but I am considering changing the entire network to Ubiquity

## Changes
With these purchases I decided to reconfigure the cluster, so rather than 4 worker PIs, 1 control PI, 2 x86 workers I now have the following

- 5 Raspberry PI4s as workers
- DL360g8 as control, and master
- R715 as worker and master
- DL160g6 as database runner

At the same time I switched to a FTTP provider, and now I have 1gb synchronous instead of 1gb/30mb

Hopefully this means I should have less issues, and less downtime
