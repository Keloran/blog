---
title: "BugFix.es Progress"
date: 2020-01-07T14:55:05+01:00
draft: false
series: bugfixes
tags: [
	bugfixes,
	projects
]
---
Progress has been slow to start with, but that should now speed up

I have finished the authorizer, and moved the storage system to Postgres from Dynamo, the main reason for that is that a lot of the data is relational
so it makes sense to put it in a relational database

### Nest
This is the service where all CRUD operations take place, it is also what triggers Hive

### Hive
This is the service that works out what to do with a bug, is it a new one, has it happened before, is it happening frequently, it also triggers the notification system

I estimate that an end-to-end system with Slack as the notification result will be in place at the start of Feb

---
[Github Link](https://github.com/bugfixes)
--
[Home](/)