---
title: "Mailspring Inverse Images"
date: 2023-01-09T22:19:57Z
draft: false
series: none
type: post
tags: [
  darkmode,
  Mailspring,
  Dracula
]
---

# Inverse Images in Mailspring
So I run most apps in darkmode, and this can lead to a few issues, namely in Mailspring which does darkmode in the "easy" method, which is to inverse(100%) everything
now this makes general emails really easy, the problem is when you get to images, because inversed images are horrible to look at

So I got bored over new year, and decided I was sick of looking at them, and because I use Dracula for everything, I set off on my journey

#### [Dracula](https://draculatheme.com)
Now Dracula is an awesome set of themes, that has pretty much support in every app that most devs use, if it doesnt then its probably coming soon

#### [Mailspring](https://getmailspring.com)
Mailspring is an email client that was started by the people who did N1, which is another mail client, the reason I use it is because non webmail clients are becoming harder and harder to find
and this one also supports Gmail, iCloud, and most important to me IMAP

## The Journey begins
The problem of inverse images has existed in mailspring for a while, and there is no easy solution for this, and the "fix" I implemented is not a solution by any stretch of the imagination, it is a bandaid

The first thing I did was look at how the them did its thing, I was hoping it was a sensible method of doing style replacement, or a clever method of doing the same thing, instead if like all darkmode in Mailspring was doing inverse(100%) on email content
this is not good, because it means every element is inversed and I had to re-inverse or stop the inversion on images

So that was the intial tact find the "img" tags and stop the inversion, this worked and was a lot easier than I thought, horray, so clicked through some emails and everything seemed fine, that was until I got to an email that was using "background-image"
and now the problem exited again, damn it

I wasn't the first to notice that background image inversion was nasty, it was spotted reported in [2018](https://github.com/Foundry376/Mailspring/issues/1191]) and in [2021](https://community.getmailspring.com/t/dont-invert-images-with-dark-theme/536/9)
it was moved to the forum, so this bug has existed for a while

Luckly because Mailspring supports themes and plugins and is written in electron, I can hijack the element and inject some JS into it, so I did it with brute force and got it working

```
export default class BackgroundImageFix extends MessageViewExtension {
  static renderedMessageBodyIntoDocument({document, message, iframe}) {
    const frameDocument = iframe.contentWindow.document;

    const tags = frameDocument.querySelectorAll("*");
    tags.forEach(tag => {
      let fixInvert = false;

      if (getComputedStyle(tag).backgroundImage !== 'none') {
        fixInvert = true;
      }
      if (tag.tagName === "IMG") {
        fixInvert = true;
      }

      // using this method so more can be added later
      if (fixInvert) {
        tag.style.filter = "invert(1)";
        tag.style.color = "#000";
      }
    })
  }
}
```

## [Released](https://github.com/dracula/mailspring)
Now this method is not good, its very system intensive, but it works, and it gets destroyed and re-initiated on each mail opened, which is the nature of the plugins in mailspring

But it works, and is now part of the Dracula official theme for Mailspring

