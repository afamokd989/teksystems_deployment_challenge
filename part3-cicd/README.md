## PART 3 - CICD
### AWS LAMBDA - Github actions deployment and Terraform Provisioning to create existing function

### Directory Structure;
```
part3-cicd/task3-lambda-deploy/
├── bootstrap-lambda.py         # Bootstrap Lambda script for initial deployment
├── lambda_function.py          # Main Lambda handler for runtime
├── bootstrap_lambda.zip        # Zipped bootstrap code used by Terraform
├── requirements.txt            # Python dependencies for Lambda
├── lambda.tf                   # Terraform resources (Lambda, IAM role, etc.)
├── vars.tf                     # Terraform variables definition
├── terraform.auto.tfvars       # Variable values (e.g., region, function name)


```

### Assumptions
**These projects assume;**
+ You have an existing AWS account with access credentials.
+ Your AWS CLI is properly configured with permission to create IAM roles and Lambda functions.
+ Terraform is installed and available in your $PATH.
+ GitHub repository has the following secrets configured:
    + AWS_ACCESS_KEY_ID
    + AWS_SECRET_ACCESS_KEY
    + AWS_REGION
+ The Lambda function name (afam-financial-lambda) is created once by Terraform, and later updated via GitHub Actions.
+ You are running all commands from the part3-cicd/task3-lambda-deploy/ directory unless otherwise noted.
+ You zipped bootstrap-lambda.py as bootstrap_lambda.zip before applying Terraform.
+ The main deployment pipeline targets lambda_function.py (not the bootstrap).

## Terraform: Create Lambda Function

**_Prerequisites_**
+ Terraform v1.0 or higher
+ AWS CLI with appropriate credentials

## Run Terraform

```
cd part3-cicd/task3-lambda-deploy/

# Ensure zipped Lambda code exists
zip bootstrap_lambda.zip bootstrap-lambda.py

terraform init
terraform fmt
terraform validate
terraform apply


```

## GitHub Actions: Lambda Code Deployment
**Located here:**
```
.github/workflows/lambda-deploy.yml

```
## Workflow logic for Github actions pipeline
```
Triggered on push to main when task3-lambda-deploy/ changes.

Installs Python 3.11 and dependencies from requirements.txt.

Zips lambda_function.py and its dependencies.


Deploys zipped package to afam-financial-lambda function using appleboy/lambda-action.
```
## Resource screenshots
Lambda
<img width="1873" alt="Screenshot 2025-06-25 at 3 00 32 PM" src="https://github.com/user-attachments/assets/3805b9a4-f590-4e26-85eb-62b32ad6197f" />
EC2 Instance/VM
<img width="1669" alt="Screenshot 2025-06-25 at 3 03 35 PM" src="https://github.com/user-attachments/assets/dad14795-b106-4194-914f-2df3f9165b96" />
<img width="1915" alt="Screenshot 2025-06-25 at 3 07 13 PM" src="https://github.com/user-attachments/assets/b061bec8-92f2-4787-96b9-ed16f8b729ce" />
