---
layout: default
title: Beazley Enrollment Platform
category: portfolio
modal-id: 5
img: beazley.png
alt: Screenshot of application that allows bulk employee enrollment and managements for groups
client: Beazley
application: Beazley Group Portal
project-date: Nov 2014 - May 2015
languages:
- PHP
- SQL
- HTML/CSS
- JavaScript
- XML
concepts:
- MVC
- AJAX
- Web Services
- UI/UX
- Scalability
tools:
- MVC Framework
- jQuery
- jQuery UI
- Dimensions (VCS)
- Git
- Postman
stack:
- Linux
- Apache
- MySQL
- PHP
- DB2
---

### Project Description

Beazley had a group enrollment platform where the companies could only enroll one employee at a time using a wizard-based flow.

The task on this project was to overhaul it to facilitate real-time mass-employee enrolling. We were tasked to: 

- Allowed bulk, asynchronous adds/changes of employees and coverages
- Integrate into the existing Beazley Employer Portal that their groups use
- Ensure fast performance and real-time enrollment processing

### Contributions

I worked on a team of developers that worked directly with the business unit as well as the middleware teams who provided the real-time enrollment processing web services.

Some of the tasks we split up amongst ourselves were:

- Design interactive jQuery UI allowing adds/changes to be done on one screen
- Submit enrollments to a backend Java/WMB XML web service using AJAX
- Add real-time status tracking of new enrollments and changes

On top of these design & development tasks, I took on the job of predicting, organizing, and estimating every task we all had to do to ship the product.

### Challenges Overcame

This project was the biggest undertaking I had to date in terms of cross-team coordination due to all the Java technology being leveraged:

- **WMB** - Manage queues and inter-application communications/mapping
- **Business Rules Team** - Validate business rule on XML request from us
- **Java Team** - Transform validated XML request into 834 flat file for Admin
- **Admin/COBOL** - Issue policies & changes on the mainframe

### Accomplishments

The greatest accomplishment of this project was that our system saves the insured companies/groups dozens of hours every enrollment period, reducing their frustration and increasing their satisfaction as Beazley customers.