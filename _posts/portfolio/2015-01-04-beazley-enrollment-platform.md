---
layout: default
category: portfolio
modal-id: 1
img: beazley.png
alt: Screenshot of application that allows bulk employee enrollment and managements for groups
client: Beazley
application: Beazley Group Portal
project-date: 2015
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
- W1 Framework
- jQuery
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

Policy Change Quoting, known internally as "In-force Quoting", is a web application used internally by sales representatives in Healthplan Services' call center to calculate new premiums for changes against members' existing policies, such as:

- Add new dependents
- Move to new addresses
- Add or change coverages 

### Contributions

I worked on a team of three developers that worked directly with the business unit and policy rating teams to gather requirements and brainstorm how to overcome issues in the existing policy quoting applications used by Cigna and Coventry at the time.

The design phase concluded with a 20-page high level design document outlining:

- Problems with existing in-force quoting applications
- Business solutions to those problems
- System changes
  - Hierarchy of system controllers and views
  - Navigation
  - Error handling
- Design of each step in quoting process, including flow diagrams
- Overview of business features in each step in quoting process

My contributions during the development phase consisted of writing or co-writing:

- System-level models and controllers
- Preprocessor that gathers:
  - Policy-level & tier information
  - Employee & dependent information
  - Benefits & plans
  - Billing & premium data
- Module-specific views, controllers, and service controllers
- Error Handling

### Challenges Overcame

The biggest challenge I faced was building my first enterprise-level web application at Healthplan Services from the ground up, as well as working with a team of developers simultaneously.

One huge challenge was weighing:

- long-term performance
- maintainability
- scalability
- return-on-investment.

Scalability was the toughest challenge to overcome. This application effectively consolidated all other in-force quoting applications before it, and in their place, provided a single, scalable solution. 

It had to allow the following features to be configurable for any number of health insurance carriers:

- Policy setups
- Coverage setups
- Benefit structures
- Policy Rating engines:
    + Mainframe-based rating engine
    + DB2-based rating engine
    + Spreadsheet-based calculator engine
- Business rules

### Accomplishments

This quoting application is still in use today and continues to be a great asset to Healthplan Services. It has grown to provide policy change quoting for the following health insurance carriers:

- Coventry
- Cigna
- Florida Blue
- Blue Shield
- Aetna

The following statistics show how large the application has grown to today:

- 500,000 quotes run per year 
- 40,000 policies quoted against per year

