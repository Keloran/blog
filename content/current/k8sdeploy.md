---
title: "K8sDeploy.dev"
date: 2021-10-13T15:05:44+01:00
draft: false
type: project_current
project: k8sdeploy
series: k8sdeploy
tags: [
    k8sdeploy,
    projects,
    kubernetes,
    chewedfeed
]
---
This project is so that I can deploy projects into my cluster using github pipelines

now that sounds simle enough, except there aren't any (from my limited research) deployment agents for kubernetes that work on arm

So whats my plan, well this system works thus

### Method
There is a github action that is triggered in your pipeline, this talks to an orchestrator on k8sdeploy

the orchestrator then sends a message to a queue with a topic for an agent that has been registered by you for your cluster

the agent in the cluster listens to the queue for instructions to go get a new deployment, the agent then goes and grabs any resources that are required for your deployment (container image for example) and deploys it

it then sends a message back to the orchestrator to say if it was successful or not

## Agent
There is an agent that sits in your cluster, it is the only one that knows any secrets in your cluster (e.g. registry logins)

#### Listening
The agent either listens on 1 or 2 topics
 - 1: Agent specific topic that is only known by your agent, and the orchestrator which only knows an agentid (the orchestrator has no knowledge of any secrets or any other details)
 - 2: an opt-in choice of auto update, there will be updates to the agent to add new functionality and it is upto you during the setup process of the agent if you want this to be done automatic or when you wish


## Orchestrator
This sits on K8sdeploy, this asks agents for some details, e.g. deployment names, and namespaces, this is so that when an action is triggered it can direct the agent to do the correct things

The orchestrator gets a signal from a github action to do a deployment, depending on if the action has a valid key, it then looks for that key finds an agents associated with that key, and then triggers a deployment signal on the queue for that agent to go do the deployment

## Github Action
This sits in your github workflow, and can tell the orchestrator to do a deployment if the workflow is successful (e.g. build a new website)

## Website / Dashboard
This is here purely to get status updates of deployments, register new agents / github actions, and to tell ask the agent to get details from the cluster, e.g. namespaces and deployment names

---
[Github Link](https://github.com/k8sdeploy)

[Company Site](https://k8sdeploy.dev)
