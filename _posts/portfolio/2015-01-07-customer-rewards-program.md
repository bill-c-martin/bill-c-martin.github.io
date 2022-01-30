---
layout: portfolio_post
title: Customer Rewards Program
category: portfolio
modal-id: 7
img: rewards.png
alt: Screenshot of eCommerce website featuring the rewards program
overview:
  application: eCommerce Site
  client: CBD Product Manufacturer
  project-date: July 2020 - October 2020
skills:
  languages:
    - PHP
    - SQL
    - HTML
    - JavaScript
    - JSON
  concepts:
    - REST APIs
    - JDKs
    - Action/Filter hooks
    - wc-cli
    - Custom plugins
  tools:
    - Bootstrap
    - jQuery
    - Git
    - Postman
    - Swell widgets
    - VS Code
  stack:
    - WooCommerce/Wordpress
    - Amazon Linux (EC2)
    - NginX
    - MariaDB
    - PHP
---

### Project Description

[Swell Loyalty & Referrals](https://www.yotpo.com/platform/loyalty/) is a rewards program that maximizes customer engagement and increases lifetime value on ecommerce platforms, by awarding points for actions and purchases which are redeemable as discounts in checkout.

The goal of this project was to develop a custom Wordpress/WooCommerce plugin for hempbombs.com to integrate with Swell through their widgets, JavaScript SDK, and REST API.

### Contributions

My primary lead contributions were:

- Spearheaded project from inception to completion, handling coordination, estimates, and burndown
- Worked with marketing team to help:
  - develop requirements from Swell technical feature set and constraints
  - leverage dynamic Swell widgets on site pages they published
- Orchestrated multi-deployment rollout gradually and without issue

My developer contributions were:

- Built out Swell API in our Postman team workspace
- Developed custom WooCommerce plugin to integrate with Swell
- Devised custom tool to generate, load, and synchronize reward coupons between the WooCommerce and Swell systems.

I developed the custom WooCommerce plugin from the ground up with the following contributions:

- Built custom coupon type in WooCommerce exclusively for rewards
- Synced new account registrations with Swell through their REST API
- Injected cart feature for rewards members to redeem points for discounts
- Triggered orders to sync points via Swell REST API:
  - New orders: Awarded points based on order total x VIP tier multiplier
  - Refunded orders: Revoked points based on amounts refunded
- Built Account area to view points balance, rewards history, and VIP tiers

### Challenges Overcame

The primary challenges of this project were due to unfamiliar territory:

- Complexities of WooCommerce's codebase, action/filters, and DB structure
- Swell's REST API, JDKs, and general rewards program business domain
- Plugin design in WooCommerce that injects at touchpoints all across the site

### Accomplishments

The project spanned 4 months, and released on time.

Business accomplishments:

- 27% participation rate in the customer rewards program
- 21% increase in order revenue for redeeming customers vs non-redeeming
- 6% revenue increase overall

By the end of project, I was well-positioned to advise my team going forward on:

- Wordpress/WooCommerce database complexies and intricacies
- Custom plugin development for Wordpress
- Ins and outs of finding and leveraging action/filter hooks across entire codebase and 3rd party plugins

Lastly, this project ultimately established the architectural approach for custom plugins going forward, which later served as a baseline for numerous other custom plugins developed at the company.
