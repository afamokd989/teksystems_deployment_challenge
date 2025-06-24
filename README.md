# teksystems_deployment_challenge
This repository contains completed solutions for the TEKsystems Control Deployment Engineer technical challenge, categorized into three parts:


- **Part 1: Cybersecurity Scenario** - Threat Intelligence, Incident response planning and network defense recommendations.
- **Part 2: Container Security Implementation** - Docker and Kubernetes hardening with IAAS considerations.
- **Part 3: CI/CD Pipeline Setup** - Serverless Lambda App deployment using Github actions pipeline.

---------------

## Repository structure

```


.
├── README.md
├── part1-cybersecurity               # Part 1 Cybersecurity analysis and documentation
│   └── README.md
├── part2-container-security
│   ├── Dockerfile                    # Hardened Dockerfile with best practices
│   ├── README.md                     # Part 2, Explanation and configurations
│   └── main.py                       # Python application
└── part3-cicd                        # Part 3 Infrastructure provisioning and GitHub Actions for serverless deployment
    ├── task1-terraform-nginx         # Task1 Terraform webserver deployment
    │   ├── main.tf
    │   ├── outputs.tf
    │   ├── provider.tf
    │   ├── terraform.auto.tfvars
    │   ├── terraform.tfstate
    │   ├── terraform.tfstate.backup
    │   └── variables.tf
    └── task3-github-actions-lambda
        ├── lambda_function.py
        ├── requirements.txt
        └── .github
            └── workflows
                └── lambda-deploy.yml

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