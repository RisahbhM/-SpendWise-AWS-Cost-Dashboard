# 💸 SpendWise - AWS Cost Monitoring Dashboard

SpendWise is a real-time, serverless AWS cost tracking and alerting system. It monitors your AWS usage costs, stores data securely, triggers proactive alerts via email/SMS, and provides a clean static dashboard. It is fully automated and deployed via Terraform.

![image](https://github.com/user-attachments/assets/b51f2900-0126-471b-9ea5-eaaa09422246)


## ✅ Architecture Overview

![image](https://github.com/user-attachments/assets/90d0107f-cd46-4c22-9e56-cbffd5c0f726)

💡 Key Features
🚨 Automated billing alerts when costs exceed threshold

📝 Stores daily cost data in DynamoDB

🎛️ Static SpendWise dashboard hosted on Amazon S3

☁️ Optional CloudFront CDN for faster global access

🛡️ Least privilege IAM policies for Lambda + S3

📥 Fully automated infrastructure via Terraform

🧩 AWS Services Used

| Service                   | Purpose                  |
| ------------------------- | ------------------------ |
| **S3**                    | Static dashboard hosting |
| **CloudFront** (optional) | Global content delivery  |
| **Lambda**                | Cost polling & alerting  |
| **DynamoDB**              | Store daily spend data   |
| **SNS**                   | Send notification alerts |
| **CloudWatch**            | Logs and metrics         |
| **IAM**                   | Secure role permissions  |

📂 Project Structure

SpendWise-AWS-Cost-Dashboard/
├── lambda/
│   ├── cost_alert.py      → Lambda function code
│   └── index.html         → Demo dashboard page
├── main.tf                → Main Terraform infrastructure
├── variables.tf           → Input variables for Terraform
├── outputs.tf             → Output values
├── provider.tf            → AWS provider configuration
├── terraform.tfvars       → Variable values
├── .gitignore             → Files to exclude from git
├── README.md              → Project documentation
└── .terraform.lock.hcl    → Terraform provider lock file

🛠️ Prerequisites

AWS account with Admin access

Terraform v1.3+ installed

AWS CLI configured (aws configure)

Basic understanding of AWS + Terraform

🚀 Getting Started

1️⃣ Clone the Repository

git clone https://github.com/RisahbhM/-SpendWise-AWS-Cost-Dashboard.git
cd SpendWise-AWS-Cost-Dashboard

2️⃣ Initialize Terraform

terraform init

3️⃣ Preview Changes

terraform plan

4️⃣ Deploy Infrastructure

terraform apply

![image](https://github.com/user-attachments/assets/d6b62f54-3b62-45cd-806c-870f7b2b8dd3)

![image](https://github.com/user-attachments/assets/2516c342-3c56-49f0-ac19-9349e5362af5)

![image](https://github.com/user-attachments/assets/5eac2139-7492-4560-8dac-03602623e489)

![image](https://github.com/user-attachments/assets/fa560491-3e6d-4207-9e3b-154cfa55f969)

![image](https://github.com/user-attachments/assets/fd02c290-fcd1-46bf-8f28-d53e47c44e5b)

![image](https://github.com/user-attachments/assets/133cd03a-0065-4a1b-a8c7-c9fbb4ff9bac)

![image](https://github.com/user-attachments/assets/e3d02bc0-6bc6-4190-be36-f72f254cb443)



📝 How It Works
Lambda polls AWS Cost Explorer API

Saves daily spend in DynamoDB

Compares spend to threshold → if exceeded, triggers SNS alerts (email/SMS)

Dashboard is served from S3 + CloudFront (optional)

🛡️ Security & IAM
Principle of Least Privilege is applied

Lambda role only has access to DynamoDB table + SNS topic + Billing data

⚠️ Known Limitations
Single AWS account support only

AWS Cost Explorer API permissions require manual setup

S3 Public Block must be adjusted for public dashboard access

🙋‍♂️ Author
Rishabh Ravi Madne
Email: rishabhmadne1623@gmail.com

🖼️ Suggested Architecture Diagram
You can create & upload this architecture diagram to GitHub:

Draw.io
Excalidraw
Lucidchart
Use the architecture from this project as reference.

⭐ Contribution Guidelines
Pull requests are welcome!
Please open an issue first to discuss what you would like to change.







