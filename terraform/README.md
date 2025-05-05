# Terraform Configuration for Website Portfolio Infrastructure

This folder contains the Terraform configuration files for deploying the infrastructure required for the **Website Portfolio** project. The infrastructure includes an API Gateway, Lambda function, S3 bucket for static website hosting, and a CloudFront distribution.

---

## Table of Contents

- [Overview](#overview)
- [Infrastructure Components](#infrastructure-components)
- [Usage](#usage)
- [Outputs](#outputs)
- [File Structure](#file-structure)
- [Troubleshooting](#troubleshooting)

---

## Overview

This Terraform configuration deploys the following resources:

- **API Gateway**: Handles HTTP requests and invokes the Lambda function.
- **Lambda Function**: Processes requests and interacts with DynamoDB.
- **S3 Bucket**: Hosts the static website files.
- **CloudFront Distribution**: Provides a CDN for the static website.
- **DynamoDB Table**: Stores view count data for the website.

---

## Infrastructure Components

### API Gateway

- **Path**: `/view_count`
- **Methods**:
  - `POST`: Invokes the Lambda function.
  - `OPTIONS`: Handles CORS preflight requests.
- **CORS Headers**:
  - `Access-Control-Allow-Origin`: `*`
  - `Access-Control-Allow-Methods`: `POST, OPTIONS`
  - `Access-Control-Allow-Headers`: `Content-Type`

### Lambda Function

- **Name**: `get_view_count`
- **Runtime**: Python 3.13
- **Role**: IAM role with permissions to access DynamoDB.

### S3 Bucket

- **Purpose**: Hosts the static website files.
- **Public Access**: Restricted via CloudFront Origin Access Identity (OAI).

### CloudFront Distribution

- **Purpose**: Serves the static website with caching and HTTPS.
- **Default Root Object**: `index.html`

### DynamoDB Table

- **Name**: `resume-website-count`
- **Purpose**: Stores the view count for the website.

---

## Prerequisites

...

Before deploying the infrastructure, ensure the following prerequisites are met:

1. **Terraform Installed**:

   - Install Terraform by following the [official installation guide](https://www.terraform.io/downloads.html).

2. **AWS CLI Configured**:

   - Install and configure the AWS CLI with appropriate credentials:
     ```bash
     aws configure
     ```
   - Ensure the AWS CLI is authenticated and has permissions to create the required resources.

3. **Python Installed**:

   - Ensure Python is installed on your system to package the Lambda function.
   - Verify the installation:
     ```bash
     python --version
     ```

4. **Lambda Function Code**:

   - Ensure the `get_view_count.py` file is present in the `../lambda_functions` directory.

5. **Static Website Files**:

   - Ensure the static website files (e.g., `index.html`, `styles.css`) are present in the `../static-website-src` directory.

6. **IAM Permissions**:

   - The AWS credentials used must have permissions to create the following resources:
     - API Gateway
     - Lambda
     - S3
     - CloudFront
     - DynamoDB

7. **DNS Configuration**:

   - Ensure that your domain provider (e.g., Route 53, GoDaddy, Namecheap) is configured to point your custom domain to the CloudFront distribution.
   - Add a **CNAME** record for your custom domain (e.g., `alw-cloud-resume.alwells.live`) pointing to the CloudFront distribution's domain name.

   Example CNAME Record:

   - **Name**: `alw-cloud-resume.alwells.live`
   - **Type**: `CNAME`
   - **Value**: `<CloudFront Distribution Domain Name>` (e.g., `d123456abcdef.cloudfront.net`)

   - If you are using Route 53, you can use an **Alias Record** instead of a CNAME:
     - **Name**: `alw-cloud-resume.alwells.live`
     - **Type**: `A`
     - **Alias Target**: `<CloudFront Distribution Domain Name>`

---

## Usage

### Steps to Deploy the Infrastructure

1. **Initialize Terraform**:

   ```bash
   terraform init
   ```

2. **Apply Configuration**:
   ```bash
   terraform apply
   ```
