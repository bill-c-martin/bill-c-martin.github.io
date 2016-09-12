---
layout: default
title: Covered California Marketplace
category: portfolio
modal-id: 4
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
- Single Sign-On
- Asymmetric Cryptography
- Encryption
- SOAP Services
- REST APIs
- Design Patterns
tools:
- Ping Federate
- Git
- Postman
- SoapUI
- CyberArk
- CyberSource
stack:
- Linux
- Apache
- MySQL
- PHP
---

### Project Description

Through an in-house-built web application called PaySafe, Healthplan Services tokenizes and processes payments for various health insurance companies on the Heathcare.gov Federal Marketplace.

Some states have elected to run their own [state-based marketplaces](http://kff.org/health-reform/state-indicator/state-health-insurance-marketplace-types/) that are not part of Healthcare.gov. Paysafe was initially designed around the strict standards of the Federal Marketplace, which state-based marketplaces do not have to follow.

The goal of this project was to setup and process payments for Blue Shield of California from the Covered California state-based marketplace. In order to support this, Paysafe had to be upgraded for greater overall flexibility:

- Accept varying requests, not just Healthcare.gov-formatted SAML XML
- Allow configurable client-specific business processes, such as:
  - Pay Later Feature
  - Duplicate payment checking that runs inside of Paysafe
  - Custom confirmation page data and formatting
- Send varying responses, not just Healthcare.gov-formatted POST response

### Contributions








I worked on a small team with one other talented senior web developer. 


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
