---
layout: default
title: Covered California Marketplace
category: portfolio
modal-id: 4
img: california-marketplace.png
alt: Screenshot of Covered California Marketplace
client: Blue Shield of California
application: Payment Portal
project-date: July 2014 - October 2014
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

An in-house-built, pre-existing payment portal tokenizes and processes payments for various healh insurance carriers selling coverage on the Heathcare.gov "Federal Marketplace".

A good half of the states under the Affordable Healthcare Act have elected to run their own [state-based marketplaces](http://kff.org/health-reform/state-indicator/state-health-insurance-marketplace-types/) instead. 

The payment portal was initially designed around the strict standards of that Federal Marketplace, which state-based marketplaces do not have to follow.

To scale the payment portal to any number of state-based marketplaces, it had to:

- Accept any request type, not just Healthcare.gov-formatted SAML XML
- Configure client-specific features and customizations
- Send any response type, not just Healthcare.gov-formatted POST response
- Support any type of request-level security, eg:
   - Restful POST request tokens
   - Signed SAML
   - SOAP encryption

### Contributions

This project consisted of two senior developers: myself, and another who was in charge of a different state marketplace. 

Together, we crafted the solutions that allowed this payment portal to scale to any number of state marketplaces.

We wrapped the application with configurable pre and post processors, which were in charge of the request/response handling, security, and application-level configurations.

Test harnesses were also created to simulate the state marketplaces where the users would be coming from to submit payments.

### Challenges Overcame

This project was a tidal wave of advanced concepts and technologies that I have only been previously exposed to minimally. 

I have to seriously step my game up in the areas of cryptography, SOAP web services, and SAML processing, and learned a lot of new tools in the process.

### Accomplishments

The payment portal was already highly successful, processing payments in the federal marketplace, which is roughly half of the states in the U.S.

By upgrading this application to flexibly scale to any number of state-based marketplaces, Healthplan Services is able to tap into the markets of the other half of the U.S, which all have state-based marketplaces of some kind.
