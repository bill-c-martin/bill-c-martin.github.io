---
layout: default
title: PHP7 Mass Upgrades
category: portfolio
modal-id: 8
img: php7.png
alt: Screenshot of application that allows bulk employee enrollment and managements for groups
client: Various Health Insurance Companies
application: Various quoting, enrollment, broker, payment applications
project-date: March 2017 - February 2018
languages:
- PHP 7
concepts:
- MVC
- Web Services
- Cron Jobs
- Performance Testing
- Regular Expressions
- Team Leading
tools:
- MVC Framework
- Rational Team Concert
- phpcodesniffer
stack:
- Linux
- Apache
- MySQL
- PHP7
- DB2
---

### Project Description


15k errors, 17k warnings, across 16k files
75% fixed with internally-developed automation scripts using regular expressions, phpcodesniffer

year long project, team of 6 developers, gradual releases

some 50 or so URLs for internal and external applications for health insurance companies

Team leading with managers, QA, business users, and a project manager, deadlines, linux/network teams, etc

Coordinating switchovers

New server setups, apach vhosts, firewall, proxypass, testing



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
