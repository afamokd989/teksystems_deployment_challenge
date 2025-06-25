# teksystems_deployment_challenge
This repository contains completed solutions for the TEKsystems Control Deployment Engineer technical challenge, categorized into three parts:


- **Part 1: Cybersecurity Scenario** - Threat Intelligence, Incident response planning and network defense recommendations.
- **Part 2: Container Security Implementation** - Docker and Kubernetes hardening with IAAS considerations.
- **Part 3: CI/CD Pipeline Setup** - Serverless Lambda App deployment using Github actions pipeline.

---------------

## Repository structure

```
.
├── .github
│   └── workflows
│       └── lambda-deploy.yml        # GitHub Actions pipeline for Lambda
├── README.md
├── part1-cybersecurity
│   └── README.md
├── part2-container-security
│   ├── Dockerfile
│   ├── README.md
│   └── main.py
└── part3-cicd
    ├── README.md
    ├── task1-terraform-nginx
    │   ├── main.tf
    │   ├── outputs.tf
    │   ├── provider.tf
    │   └── variables.tf
    └── task3-lambda-deploy
        ├── bootstrap-lambda.py
        ├── lambda.tf
        ├── lambda_function.py
        ├── requirements.txt
        ├── terraform.auto.tfvars
        └── vars.tf


```


## Runbook

### Part 2 - Container Security

```bash
# Build Docker image(Dockerfile) including the security best practices
cd part2-container-security/
docker build -t secure-app .

# Apply the Kubernetes pod configuration with securityContext
kubectl apply -f security-context.yaml
```



### Part 3 - CI/CD Pipeline

***Github Actions**:

- Workflow pipeline location; `.github/workflows/github-actions.yml`,  with linting, test case and Docker build and deploy steps included.



## Security tools utilized during this deployment

- **AWS Security Hub**; A single pane of glass to aggregate findings from Guarduty, AWS Inspector and Iam Analyzer.
- **AWS Inspector**: For CVE scanning.
- **AWS GuardDuty**
- **AWS WAF**: Web Application firewall with OWASP protection rules.

---------

## Documentation


Each section includes a `README.md` file or written documentation detailing:

- Assumptions
- Architecture choices
- Scripts and usage
- Screenshots (if applicable)


## Assumptions

- AWS is the cloud provider in this team in Afam Financial
- Kubernetes is assumed to be running on EKS(AWS)
- All the pipelines and code bases follow DevSecOps model and best practices.