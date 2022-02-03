---
title: "Update NerdCTL on RancherDesktop macOS"
date: 2022-02-03T10:46:56Z
draft: false
series: none
type: post
---

# Issue
So you are already using RancherDesktop and NerdCTL from the betas congrats, but you want to use the multi-platform build

so you need to update Rancher and Nerd, well thats where the issue exists, Lima doesnt update NerdCTL automatically so you need to update your instances version

## Fix
First you need to get into the instance
```sh
LIMA_HOME=/Users/<username>/Library/Application\ Support/rancher-desktop/lima \
	/Applications/Rancher\ Desktop.app/Contents/Resources/resources/darwin/lima/bin/limactl \
	shell 0 sudo --preserve-env=CONTAINERD_ADDRESS sh
```

Now that your in the instance, you need to update NerdCTL

I always make a copy of the original version just incase
```sh
cd /usr/local/bin/
cp nerdctl nerdctl-old
```

Now update nerdctl the download is different on M1 so go to [NerdCTL Releases](https://github.com/containerd/nerdctl/releases) and choose the latest one
```sh
cd /usr/local/bin
wget https://github.com/containerd/nerdctl/releases/download/v0.16.1/nerdctl-0.16.1-linux-amd64.tar.gz
tar -xf nerdctl-0.16.1-linux-amd64.tar.gz
rm nerdctl-0.16.1-linux-amd64.tar.gz
```

Now if you go onto a seperate terminal and do ``` nerdctl -v ``` you should now have the latest version of NerdCTL installed
