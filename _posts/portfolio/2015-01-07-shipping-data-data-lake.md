---
layout: portfolio_post
title: Data Lake ETL Process Overhaul
category: portfolio
modal-id: 9
img: datalake.png
alt: Architectural Diagram of the ETL Pipeline
overview:
  application: Data Lake
  client: CBD Product Manufacturer
  project-date: March 2020 - April 2020
  summary: Data Lake ETL pipelines that were written in Python, leveraged AWS Glue, replaced a costly legacy process, and reduced AWS bill by 50%
skills:
  languages:
    - Python
    - JSON
  concepts:
    - Data Lakes
    - ETL Jobs
    - Data Crawlers
    - Glue Workflow
    - Webhooks
  tools:
    - pip3
    - PySpark
    - AWS Athena
    - Jupyter Notebooks
  stack:
    - Apache Spark
    - AWS S3
    - AWS Glue
    - AWS Athena
---

### Project Description

#### Background Info

JSON-encoded data was continuously collected through webhooks from various systems:

- eCommerce sites (WooCommerce and Magento)
- Payment gateways (Authorize.net)
- Shipping platforms (ShipStation)

This data then flowed through an ingress pipeline process and into a data lake.

#### Problem

An AWS cost analysis revealed high costs associated with that data ingress pipeline.

This pipeline consisted of:

- Parsing unstructured JSON-encoded data by resource-intensive jobs
- Translating into relational tables in PostgreSQL
- Retrieving the data back out of PostgreSQL
- Parsing the data into Parquet files for the data lake

#### Solution

The PostgreSQL AWS RDS instance and associated jobs needed to be decommissioned and replaced with AWS Glue ETL jobs better suited for translating irregular, unstructured data into the data lake.

### Contributions

After collaborating with a senior developer and data scientist on my team, we established and refined the design and architecture of the new data ingress pipelines.

I handled the ShipStation shipping data. They handled the eCommerce and payment gateway data.

The shipping data pipeline did the following:

1. **AWS Glue Workflow**: triggers a Glue crawler once a day
2. **Glue Crawler**: crawls the S3 shipping data and groups it into tables and partitions
3. **Glue ETL**: extracts those tables and partitions, transforms the data, and loads into Parquet files in another S3 bucket
4. **Glue Crawler**: crawls the Parquet files from AWS S3 and loads into the AWS Glue Data Catalog
5. **AWS Athena**: exposes the shipping data from the Data Catalog as Athena tables

The Glue ETL job was written in Python and ran in Apache Spark.

1. **Extract**: Imported previously-crawled data
2. **Transform**: Handed data conversion, resolved choices, and mapping
3. **Load**: Wrote transformed data to Parquet files on AWS S3

### Challenges Overcame

Just about everything was a challenge due to my lack of experience with the myriad of AWS and data technologies.

The biggest challenges were:

- Finalizing the finer details of the new architecture and process with the team
- Divinating what exactly the Glue Crawlers were doing
- Tracking down and fixing subtle data integrity issues using Jupyter notebooks
- Coordinating libraries and AWS services from Python code
- Figuring out how choice resolution works and how Parquet files work

### Accomplishments

Helped established new architecture and processes for the data lake's pipelines.

Built my first production-ready Python code.

Learned a lot about data lakes and ETL from a data science perspective.

Reduced AWS bill by 50% when the legacy RDS instance and pipelines were retired.