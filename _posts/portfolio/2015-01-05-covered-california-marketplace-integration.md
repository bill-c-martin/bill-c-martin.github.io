---
layout: default
title: Covered California Marketplace
category: portfolio
modal-id: 5
img: california-marketplace.png
alt: Screenshot of Covered California Marketplace
client: Blue Shield of California
application: Paysafe
project-date: July 2014 - October 2015
languages:
- PHP
- SQL
- SAML XML
concepts:
- SSO
- Encryption
- Web Services
- Scalability
- Design Patterns
- MVC
tools:
- Ping Federate
- W1 Framework
- Git
- Postman
stack:
- Linux
- Apache
- MySQL
- PHP
---

### Project Description

The companies covered through Beazley group insurance had ongoing performance & overhead issues on their Employee Portal when adding and updating coverage for their employees during their open enrollment period every year.

The problem was that their enrollment platform could only process one employee at a time, which itself consisted of a series of slow-running, step-by-step pages.

This introduced a large amount of time and overhead for Beazley's groups.

We were tasked to: 

- Build a new enrollment platform that allowed bulk, asynchronous: 
  - Changes to existing employee coverages
  - Enrollments of new employees & coverages
- Integrate it into the existing Beazley Employer Portal that their groups use
- Ensure fast performance and real-time enrollment processing

### Contributions

I worked on a team of four developers that worked directly with the business unit as well as the Java/WMB & COBOL mainframe teams who provided the real-time enrollment processing web services.

Some of the tasks we split up amongst ourselves were:

- Design interactive jQuery UI allowing adds/changes to be done on one screen
- Submit enrollments to a backend Java/WMB XML web service using AJAX
- Add real-time status tracking of new enrollments and changes

On top of these design & development tasks, I took on the job of predicting, organizing, and estimating every task we all had to do to ship the product.

### Challenges Overcame

Time and deadlines were the biggest challenge on this project. We had a lot of tasks to divide amongst four developers who were added to the project last minute. 

We pulled through and make the deadline though!

This project was also the biggest undertaking I had to date in terms of cross-team coordination. 

On top of my team of four PHP web developers, we have the following teams to coordinate with, all building our pieces in parallel:

- **WMB** - Manage queues and inter-application communications/mapping
- **Business Rules Team** - Validate business rule on XML request from us
- **Java Team** - Transform validated XML request into 834 flat file for Admin
- **Admin/COBOL** - Issue policies & changes on the mainframe

### Accomplishments

The greatest accomplishment of this project was that our system saves the insured companies/groups dozens of hours every enrollment period, reducing their frustration and increasing their satisfaction as Beazley customers.