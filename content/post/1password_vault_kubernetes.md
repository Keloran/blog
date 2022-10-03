---
title: "Integrating Vault with 1Password in Kubernetes"
date: 2022-01-10T17:14:04Z
draft: false
series: kubernetes
type: post
tags: [
  1password,
  kubernetes
]
---

# Integrating Vault with 1Password in Kubernetes
I decided that I should probably get a real handle on my passwords and secrets in kubernetes, since kubernetes is not very good at keeping secrets

So I don't generally take a helm chart or kube-schema at face value, this has more to do with I prefer to keep things in their own namespace rather than in "default", because of this I tend to clone the chart first

My kubernetes cluster is both ARM64 and AMD64 as such, I try to only run things that have both sets of images, but if there is no ARM version then I have a fallback at least, I also use [longhorn](https://longhorn.io) as my storage solution becuase of its ability to adapt

## How I got it working
The following is all steps that I took, they aren't perfect, but it is working

### Install [Vault](https://vaultproject.io) 
I used helm for this, with my own twist  
```yml
server:
  resources:
    requests:
      memory: 256Mi
    limits:
      memory: 512Mi
  dataStorage:
    enabled: true
    storageClass: longhorn
  auditStorage:
    enabled: true
    storageClass: longhorn

ui:
  enabled: true
  serviceType: LoadBalancer
  externalPort: 80

standalone:
  config: |
    ui = true
    listener "tcp" {
      tls_disable = 1
      address = "[::]:8201"
      cluster_address = "[::]:8201"
    }
    storage "file" {
      path = "/vault/data"
    }
    plugin_directory = "/vault/data/plugins"
```

```bash
helm install vault hashicorp/vault --namespace vault -f vault.yml
```

this enables me to use longhorn's storage class, and turns on the UI

### Install [OnePassword Connect](https://github.com/1Password/onepassword-operator)
The guide is pretty good on there, the only difference is I wanted it installed in the Vault namespace  
```bash
helm install connect 1password/connect \
	--set-file connect.credentials=1password-credentials.json \
	--namespace vault
```

### Install [OnePassword Vault Backend](https://github.com/1Password/vault-plugin-secrets-onepassword)
I did this part quite different, because I'm using longhorn as my storage I know that its persistent so I can login to the vault image and change the file structure

So the first thing I did was go into the kubernetes dashboard (rather than doing it through terminal direct, and mounting it as a proxy), and then opened a terminal into the vault pod  

Because I have my vault running on ARM nodes, I wget the ARM zip, unzipped into the correct folder, renamed the file that comes out of the zip to ```op-connect```, rather than ```vault-plugin-secrets-onepassword_v1.0.0```  

Then I followed the instructions in the guide

___
As I say this isn't a perfect guide, but hopefully it helps others and me when I rebuild my cluster in the future
