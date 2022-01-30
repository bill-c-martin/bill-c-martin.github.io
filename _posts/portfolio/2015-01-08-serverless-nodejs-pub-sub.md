---
layout: portfolio_post
title: Serverless Pub/Sub Node.js Process
category: portfolio
modal-id: 8
img: pubsub-overview-800-577.png
alt: Architectural Diagram of the Process
client: CBD Product Manufacturer
application: Email Subscription List Synchronizer
project-date: Nov 2020
skills:
  languages:
    - TypeScript
    - JSON
  concepts:
    - Cloud-Native
    - Serverless
    - REST APIs
    - Promise Chaining
    - S3 Fanouts
  tools:
    - NPM
    - AWS Secrets Manager
    - AWS CloudWatch
    - AWS EventBridge
  stack:
    - Node.js
    - AWS S3
    - AWS Lambda
    - AWS SNS
---

### Project Description

[Klaviyo](https://www.klaviyo.com/) is an email & SMS marketing automation platform and they offer [a robust API](https://developers.klaviyo.com/en/reference/get-list-info). One of the many feature it has is segmentation lists for target segments of one's customer base.

The purpose of this project was to synchronize some of these segmentation lists out to 3rd party advertising platforms.

The three caveats were:

- The segmentation lists can grow or change
- There can be `n` number of 3rd party advertising platforms we send these lists to
- APIs of those 3rd party platforms will be wildly different

Therefore, this needed to be a configurable and scalable process.

### Contributions

After some research, vetting, and collaboration with my team, I ultimately proposed this publisher/subscriber, serverless achitecture in AWS:

- **AWS EventBridge**: to configure daily triggers for each segmentation list to sync
- **AWS S3**: to store/retrieve segmentation lists from Klaviyo's API
- **AWS SNS**: for the publisher to communicate to the AWS Lambda "subscribers" via SNS fanouts, and to send email notifications
- **AWS Secrets Manager**: for storing/retrieving API keys securely
- **AWS Lambda**: for the publisher/subscribers to coordinate all the above services and vendor REST APIs

The publisher and subscribers AWS Lambda functions ran in Node.js environment.

I wrote them in TypeScript with promise chaining due to the asynchronous nature of the AWS services libraries, and also due to the procedural nature of coordinating S3, SNS, Secrets Manager, Klaviyo's API, and the downstream advertisers' APIs.

### Challenges Overcame

The challenges of this project were derived from its constraints:

- **Cost efficiency**: only needed to run once a day, and briefly
- **Scalability**: must support `n` number of advertising platforms with varying APIs
- **Flexibility**: Segmentation lists retrieved from Klaviyo needed to be configurable

From these constraints, the pub/sub setup was chosen to solve them.

Since I started learning AWS earlier that year, it was challenging determining the best AWS services to leverage and how to coordinate them all.

### Accomplishments

This was the first cloud-native serverless process I built since learning AWS in 2020.

The flexible architecture probably guarantees a long lifespan.

The implementation of this process paved the way for the marketing team to integrate with these advertising networks.
