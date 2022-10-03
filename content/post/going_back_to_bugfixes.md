---
title: "Going back to BugFix.es"
date: 2019-12-05T14:55:05+01:00
draft: false
series: bugfixes
tags: [
	bugfixes,
	projects
]
---
I have decided to go back to BugFix.es and re-start development

mainly this is due to me needing a common bug/issue tracking system (this is not a ticket system like jira)

BugFix.es tracks bugs, so if a bug is sent to the system and it hasn't been seen before or was seen a long time ago, or is happening a lot in a short period of time
it creates a ticket / notification so development on it can be tracked/done

#### Why is it needed
If your getting a bug that occurs once every 10k hits it only triggers once, the same happens if your getting a bug that triggers every hit only create 1 ticket, don't create hundreds

signal over noise is what is needed when it comes to triggered bugs, if all you get is noise you have no idea what the actual issue is and how much it actually affects

#### What I'm doing atm
So I've updated the NPM currently all it will do is console output since no-one has any API keys to send them to the brain

I am also in the process of creating the API side again (it was very much unmaintainable) and then I will start issuing API keys to a select group so that the brain can start getting trained

Once the brain is trained I will open the API up the public

---
[Github Link](https://github.com/bugfixes)
--
[Home](/)