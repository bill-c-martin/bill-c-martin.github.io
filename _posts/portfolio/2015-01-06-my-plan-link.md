---
layout: default
title: MyPlanLink Quoting and Payments
category: portfolio
modal-id: 6
img: myplanlink-quoting.png
alt: Screenshot of MyPlanLink Quoting
client: United Healthcare, Aetna, Blue Cross, and more
application: MyPlanLink Quoting
project-date: July 2015 - January 2016
languages:
- PHP
- SQL
- XML
- SOAP XML
- JavaScript
- JSON
- ASP.NET
concepts:
- Asymmetric Cryptography
- Encryption
- SOAP Services
- REST APIs
- Payment Tokenization
- Scalability
tools:
- Git
- Postman
- SoapUI
- CyberArk
- PDFLib
- Visual Studio
stack:
- Linux
- Apache
- MySQL
- PHP
---

### Project Description

MyPlanLink is a marketplace platform for health insurance providers (aka *providers* for short) that offers their customers a branded experience to shop, quote, compare, and enroll in a variety of health, dental, and vision products.

The goal was to build a set of web services that this platform could flexibly and safely pass customer enrollment and payment information to which could then submit it to the health insurance providers. This included:

* Tokenization of payment information
* Reception of enrollment from the platform
* Transformation from received enrollment into providers' formats
* Submission of enrollments and payment information to providers' 

### Contributions

Out of a team of developers, my primary contributions were:

* Payment tokenization and ecryption
* Test harness for tokenization
* Submission of enrollments to providers

### Challenges Overcame

This was my first experience building something that tokenized and encrypted actual payment information which was a high-security, business-critical task. This involved a variety of encryption techniques and software to accomplish.

The biggest challenge was scalability. For n number of health insurance providers, there can be n number of enrollment submission methods that they themselves require to receive the enrollment, such as:

 * E-fax of PDF enrollments
 * Token-protected web APIs with enrollment as custom-formatted in JSON
 * .NET SOAP web services protected with encryption and public keys
 * PDFs sent via FTP for manual processing

### Accomplishments

This was a brand new business venture and a new concept in the development of the federal and state-run marketplaces for the Affordable Healthcare Act.

The skills I developed most were:

* Web service security techniques and standards
* Scalability
* Service-oriented architecture focus
* Encryption and tokenization
* Working with clients' technical teams directly