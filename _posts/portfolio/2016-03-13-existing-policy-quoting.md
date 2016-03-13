---
layout: default
category: portfolio
modal-id: 1
img: ifq.png
alt: Screenshot of application that quotes changes to existing policies
client: Cigna, Florida Blue, Blue Shield, Coventry, Aetna
application: Existing Policy Quoting
project-date: 2013 - 2016
languages:
- PHP
- SQL
- HTML
- CSS
- JavaScript
- XML
concepts:
- MVC
- AJAX
- OOP
- Caching
- Persistence
- Web Services
- Design Patterns
tools:
- Dimensions (VCS)
- PhpStorm
- notepad++
- putty
- vim
- WinSCP
- SQLYog
- Postman
frameworks:
- W1 (in house)
- jQuery
- UI Controls (in house)
stack:
- Linux
- Apache
- MySQL
- PHP
- DB2
---

###Project Description
Existing Policy Quoting, which was internally called "In-force Quoting", is a quoting web application used internally by salesreps in Healthplan Services' call center. 

They use it to calculate new premiums for changes against existing policies, such as:

- adding new dependents
- moving to new addresses
- adding or changing coverages 

###Contributions
I started off spearheading this project alone, working with the business unit and policy rating teams to gather requirements and brainstorm how to overcome issues in the existing in-force quoting applications used by Cigna and Coventry at the time.

I lead most of the design efforts as well, towards the end of which, two other developers joined the project.

The design phase concluded with a 20-page high level design document which outlined:

- Problems with existing in-force quoting applications
- Business solutions to those problems
- System changes
  - Hierarchy of system controllers and views
  - Navigation
  - Error handling
- Design of each step in quoting process, including flow diagrams
- Overview of business features in each step in quoting process

My contributions during the development phase consisted of writing or co-writing the following with a team of two other developers:

- System-level models and controllers
- Preprocessor that gathers:
  - Policy-level & tier information
  - Employee & dependent information
  - Benefits & plans
  - Billing & premium data
- Module-specific views, controllers, and service controllers

###Challenges Overcame
The biggest challenge I faced was writing my first enterprise-level web application at Healthplan Services, which I designed and built from the ground up with two other developers.

The sheer amount of design choices to be made had to be weighed against long-term performance, maintainability, scalability, and return-on-investment.

Scalability was a tough challenge to overcome. This application effectively consolidated all other in-force quoting applications before it, and in their place, provided a single, scalable solution. 

This meant that the application had to allow the following features to be configurable for any number of health insurance carriers:

- Policy setups
- Coverage setups
- Policy Rating engines:
    + Mainframe-based rating engine
    + DB2-based rating engine
    + Spreadsheet-based calculator
- Business rules

###Accomplishments
The in-force quoting application is still in use today and continues to be a great asset to Healthplan Services. It currently provides policy change quoting for the following health insurance carriers:

- Coventry
- Cigna
- Florida Blue
- Blue Shield
- Aetna

The following statistics show how large the application has grown to today:

- 500,000 quotes run per year 
- 40,000 policies quoted against per year

