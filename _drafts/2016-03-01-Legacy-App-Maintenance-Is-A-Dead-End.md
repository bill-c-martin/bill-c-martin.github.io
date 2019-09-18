---
layout: blog_post
title: Legacy App Maintenance Is A Dead End
category: blog
---

All programmers should post a sign at the precipice descending into their old code: "Abandon all hope, ye who enter here".

Legacy app maintenance is the Bane of the Pragmatic Programmer; the Path to Code Janitor; where the code's developers are usually long gone and there is no Virgil to guide you through their Nine Circles of Hell.

Spending your days patching and maintaining your fellow developers' code of yesteryear is akin to doing their old, dirty laundry, with stains and skid marks on full display.

### Stunted Development Skills

Legacy code reprograms one's precious neural connections to support bad habits, at least to budding developers that don't know any better.

It is where the wicked gather:

* **God Classes** - That are so big, their nesting even goes off screen
* **[Poltergeist Classes](http://stackoverflow.com/questions/12801965/poltergeist-antipattern-example)** - I've always hated these and only recently discovered they  had a name
* **LongFunctionNamesThatDescribeAllTheStuffThatTheyDo** - There really needs to be a catchy name for this as well as other types of [naming daftness](https://www.quora.com/What-are-the-most-ridiculous-Java-class-names-from-real-code). I propose: Linguistic Depravity.
* **[WET](http://www.artima.com/intv/dry.html) code**
* **Flag-infested method parameters** - a violation of the [Single Responsibility Principle](http://www.informit.com/articles/article.aspx?p=1392524))
* **Rigid Coupling**
* **Coding By Exception** - aka Ad hoc bandaid fixes and features
* **Reinventing the Wheel** - aka "Not Invented Here" Syndrome
* **[Broken Windows](http://www.informit.com/articles/article.aspx?p=1235624&seqNum=3)** - aka I'll just take a crap here in the open because nobody else cares about this place

However, experienced developers may find themselves picking *up* on all these code smells and anti-patterns, and actually learning how *not* to design an application. But they will likely walk away grimacing at their coworkers' past selves.

But still, a few years stuck maintaining code with these sorts of problems will find you hopelessly out dated whilst the world has sailed onto bigger, better seas.

### The Code Janitor

Here's a different sort of metaphor: All the other developers have moved on to construct bigger, better buildings, while you stick around in the old ones sweeping the hallways and locking the doors every night.

Being stuck in a cycle of maintaining dinosaur apps ends up largely being an exercise on how to apply duct tape and zip ties. The lack of creativity is mind numbing to me.

As you trade growth and development for application-specific skills, you become an expert in putting out fires and cleaning up other people's messes.

### Company Coupling

This decline in new industry skills combined with ever-increasing business domain knowledge specific to the legacy app may find you coupled to the company.

Your value becomes measured in how well you know the business domain of the app. 

At some point, there was a gradual shift from Software Engineer; somebody who builds things to solve problems, to a Software Mechanic; somebody who keeps those things running.

While the builders on the frontier are getting all of the credit, you stick around in the support lines with little recognition and visibility.

### But.. Somebody Has To Do It

Maintaining legacy code isn't inherently a bad thing though. 

After all, legacy applications linger around still because the company can [still ride its ROI curve](https://www.mendix.com/think-tank/killing-your-companys-legacy-applications-the-right-way/). If it ain't broke, don't fix it.

Besides, there is enjoyment to be had in legacy app maintenance for the right kind of programmer..

There are those who 

* Enjoy being the uncredited backbone that keeps the company going 
* Thrive as the loyal soldier fighting day-by-day problems as they arise 
* Strive for safe, stable careers at a single company until retirement

Me? I would rather innovate, than maintain. 

Everything I enjoy in programming is stolen away when I get stuck in legacy app maintenance roles.

I'm no Master Programmer either. I have a lot to learn, which is part of the reason I'm bothering to convert my thoughts into ASCII characters right now by wiggling my fingers really fast into a keyboard. 

My old code, from even two years ago, makes me cringe.

To future developers that will one day maintain my current code: Forgive me, for I know not what I do, despite all that I learn!
