---
title: "Old iPads Modern Use"
date: 2023-02-04T09:37:57Z
draft: false
series: home_automation
type: post
tags: [
	"home assistant",
	"ipad"
]
---

# Old iPads with a Modern Use
I have gone quite heavy into home automation, not too extreme (mainly because I don't have a lot of automated products) but enough that it has made an impact on my life, I have the following automations

- Automatic lights in a few rooms
  - Kitchen: the light comes on when you enter the room, and only turns off after it has been vacant for 5 minutes (if your stood at the stove and haven't moved much I don't want the light to go off)
  - Dining Room: light comes on when you go past a sensor in the hall/stairs (there isn't a sensor in the dining room)
  - Living Room: light comes on when you enter the room, and goes off if there is no activity for 5 minutes and the TV isn't on (sat at the sofa watching something shouldn't turn the lights off)
  - Stairs: Turn on when you enter the stairs either from the top or the bottom, turn off after 1 minute of no activity
  - Bedroom: Turn on in the morning, turn off when everyone "should" have left the bedroom

#### Future plans
There are plans for future automations, every room has a temperature sensor in it, and will have wall heaters (I live in the UK) that turn on when the sensor detects the temperature not the heater detecting the temperature, this is to avoid it thinking "I'm nice and warm and 10ft from the nearest person screw them"

### Where do the iPads come in
I decided that it would be nice to have a way of controling the house on a simple interface, now I can just get wireless buttons that do things, I have automatic light switches, so thats not a problem, but what if you want to know the temperature, or want to know the house calendar items, well thats where a visual interface comes in

Everyone in the house has a phone that is connected to HomeAssistant but I want something that isn't required to be on the network or know the address (e.g. if a guest wants to turn the heater on)

So with that I have decided to stick an iPad on the wall in every room in the house, not just a tablet specificly an iPad, well that was a fun idea

### Whats the problem
I went on eBay and set about getting cheap used iPads these were the following "so far"

- 1 iPad 1st gen (iOS 5.1)
- 2 iPad 2nd gen (iOS 9.3)
- 1 iPad 3rd gen (iOS 9.3)
- 1 iPad Mini 1st gen (iOS 9.3)
- 1 iPad Mini 2nd gen (iOS 12.5)

I got all of these for a grand total of ₤100, which is cheaper (at time of writing) than 2 raspberry pi's, that doesn't sound too bad, well anything below iOS 10 can't interface with Home Assistant due the way the website is written, infact most websites written in the last 3 years can't really be accessed from these devices

So how to solve this issue, VNC is your friend, pretty much every device needs a web connection to home assistant, so for each of them there is a seperate headless VNC server running [Firefox](https://github.com/jlesage/docker-firefox) this then runs on my kubernetes cluster, then the issue is getting VNC on the devices, well because I don't want these iPds on my or the families apple account, they are on a seperate account

So the latest iOS iPad can still (for now) download apps from the app store, all the others are jailbroken with the only app really installed is an app called [aDowngrader](http://h6nry.github.io/repo/Files/adowngrader/index.html) what this allows me to do is download VNC on the latest iOS, then on the older iPads it pulls the version that is the oldest compatiable with that iPad

I then run VNC on these in "touch panel" mode, which means there isn't a cursor, and it behaves as you would expect a native iPad to behave

Now I can run a newer version of Firefox that the iPad supports without worry (or at least not the worry of that)

### Exploding Batteries
Another "fun" part about iOS is that it didn't have any over-voltage/battery protection until iOS 11.3 so Home assistant also has the following automation setup

- Detect the battery percentage as reported by Apple using "find my"
- If the battery is below 20% turn on the plug used to charge the iPad
- If the battery is above 80% turn off the plug used to charge the iPad

The optimal amount of fill most batteries if they are plugged in all the time is about 80% so this has a buffer to turn on and off the plug

## Recomendations
If you were to do this, and you don't care about e-waste then I would say get a cheap Fire tablet from Amazon and do it that way, if on the other hand you want to avoid throwing away devices that "should" be fine to access websites, that is how you do it