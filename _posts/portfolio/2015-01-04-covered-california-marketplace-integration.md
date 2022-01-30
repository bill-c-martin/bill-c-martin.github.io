---
layout: portfolio_post
title: Payment Tokenization Platform
category: portfolio
modal-id: 4
img: california-marketplace.png
alt: Screenshot of Covered California Marketplace
overview:
  application: Payment Portal
  client: Blue Shield of California
  project-date: July 2014 - October 2014
  summary: Pre/post processor adapters for a high-volume payment application used on healthcare.gov, allowing it to scale out to state marketplaces as well. 
skills:
  languages:
    - PHP
    - SQL
    - SAML XML
  concepts:
    - Single Sign-On
    - Encryption
    - SOAP Services
    - REST APIs
    - Strategy pattern
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

We had an existing payment portal that tokenized and processed payments for various health insurance carriers selling coverage on the Heathcare.gov "Federal Marketplace".

A good half of the states under the Affordable Healthcare Act have elected to run their own [state-based marketplaces](http://kff.org/health-reform/state-indicator/state-health-insurance-marketplace-types/) instead.

This payment portal was designed initially around the strict standards of that Federal Marketplace, which state-based marketplaces do not have to follow.

To scale this payment portal to any number of state-based marketplaces, it had to:

- Accept any request type, not just Healthcare.gov-formatted SAML XML
- Configure client-specific features and customizations
- Send any response type, not just Healthcare.gov-formatted POST response
- Support any type of request-level security, eg:
  - REST POST request tokens
  - Signed SAML
  - SOAP encryption
### Contributions

I collaborated with another senior developer who was tasked with a different marketplace.

Together, we crafted the solutions that allowed this payment portal to scale to any number of state marketplaces.

We wrapped the application with configurable pre and post processors, which were in charge of the request/response handling, security, and application-level configurations. This mitigated risk by minimizing changes to the core, high-volume payment application.

Test harnesses were also created to simulate the state marketplaces where the users would be coming from to submit payments.

### Challenges Overcame

This project was a tidal wave of advanced concepts and technologies that I have only been previously exposed to minimally.

I have to seriously step my game up in the areas of cryptography, SOAP web services, and SAML processing, and learned a lot of new tools in the process.

### Accomplishments

The payment portal was already highly successful, processing payments in the federal marketplace, which is roughly half of the states in the U.S.

By upgrading this application to flexibly scale to any number of state-based marketplaces, Healthplan Services is able to tap into the markets of the other half of the U.S, which all have state-based marketplaces of some kind.
