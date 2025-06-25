# Part 2: Container Security Implementation – Afam Financial

In this section of the challenge, we will address the challenge of securing Afam Financial’s microservices-based application deployed via Docker and Kubernetes, using AWS as the IaaS provider.

------------------------


Here are five essential security best practices for Docker:

+ **Use Minimal Base Images**  
   Minimize attack surface by using lightweight images like `alpine`.

+ **Drop Root Privileges**  
   Always run containers as a non-root user to limit the impact of a compromise.

+ **Scan Images for Vulnerabilities**  
   Regularly scan with tools like **Trivy**, **Amazon Inspector**, **Sysdig** or **Wiz.io**.

+ **Use Read-Only Filesystems**  
   Prevent tampering by mounting root filesystems as read-only unless necessary.

+ **Use Multi-Stage Builds**
   Split the build and runtime environments to reduce image size and eliminate unnecessary tools.

### Files in this section

+ **Dockerfile**

+ **main.py**


### Best Practices used in the Dockerfile.
The security best practices used for the Docker image are outline below, also annotated in the Dockerfile.

+ Using a dedicated working directory "/app", transferring ownership to non-root user "appuser" thereby preventing permission issues or unintended privilege escalations.
```
WORKDIR /app
COPY ./main.py .
RUN chown -R appuser:appgroup /app
```
+ **Nonroot user creation:** 

```
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

```
- This code snippet is from the docker image which creates a dedicated ```appuser ``` without root privileges.

- It also ensures that the application does not run with elevated permissions inside the container.

+ Minimal image usage; Python alpine was used as the base image.

```
FROM python:3.12-alpine
```

### Runbook

+ To build the image;
```
docker build -t secure-app .    
```
+ Check if image was built.
```
docker images or docker image ls
```
+ To containerize image
```
docker run secure-app 
```

## Kubernetes Security Configuration

### Kubernetes Key Security features

+ Network Policies; Network policies ensure that we can control how pods communicate with each other, setting virtual firewalls inside a cluster, it matters because without them every pods talks to each other by default and that breaks the zero trust policy and exposes sensitive sytems like internal APIs and Databases.
In Afam financial;
    + Network policies can be used to isolate front-end apps from sensitive backend pods.
    + Only allow  API pods to communicate with the databases.
    + Block internet facing traffic from internal services.
Example;
```
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: deny-all
spec:
  podSelector: {}
  policyTypes:
    - Ingress
    - Egress
```

+ Threat Detection and Defense in Kubernetes

At Afam Financial, securing the Kubernetes environment extends beyond configuration hardening — it includes active **detection and prevention** of threats targeting workloads, pods, or the control plane.

---

#### Threat Vectors in Kubernetes
Threat actors may:
- Exploit vulnerabilities in containerized apps
- Abuse insecure cluster configurations
- Launch lateral movement attacks within the cluster
- Send malicious traffic to Kubernetes services or nodes

---

####  Key Capabilities for Defense

**1. Intrusion Detection (IDS)**  
Ability to:
- Analyze pod traffic
- Correlate suspicious patterns across workloads

**2. Intrusion Prevention (IPS)**  
Ability to:
- Automatically block malicious activity
- Prevent known attack patterns or IOCs
- Integrate with tools like AWS GuardDuty for response

+ Pod Security Standards
Pod security standards define the kind of security behaviors allowed in Kubernetes pods, thereby enforcing guardrails on what the pod can do. They are important because they help prevent risky configurations like running containers as root, mounting host File systems. In Afam financial there would be an enforcement for baseline or restricted policy across non privileged namspaces.


## Infrastructure as a Service (IaaS)

### What is IaaS?
Infrastructure as a Service (IaaS) is a cloud computing model that delivers on-demand access to virtualized **servers**, **storage**, and **networking** over the internet. It allows organizations to rent IT infrastructure from a cloud provider, scale resources as needed, and eliminate the cost and complexity of managing physical hardware.

---

### How IaaS Works

Cloud providers (e.g., AWS, Azure, GCP):
- Host the **underlying infrastructure** in secure data centers
- Offer compute, storage, and network resources via web consoles or APIs
- Let users configure and manage resources while the provider handles maintenance

**Key Model:** Pay-as-you-go  
**Outcome:** Rapid deployment, cost control, no on-premises hardware


### Benefits of IaaS

| Benefit                        | Description |
|--------------------------------|-------------|
|   **Cost Reduction**           | Eliminates the need to purchase and maintain on-prem hardware. Pay only for what you use. |
|   **Scalability & Performance**| Dynamically scale workloads across regions or during traffic spikes. |
|   **Stability & Reliability**  | Providers manage patching, upgrades, and uptime via SLAs. |
|   **Business Continuity**      | Built-in backup, failover, and disaster recovery options. |
|   **Enhanced Security**        | Providers offer enterprise-grade security controls and monitoring. |
|   **Faster Deployment**        | Infrastructure for new projects can be provisioned in minutes. |


### Summary

- **IaaS** enables flexible, on-demand infrastructure provisioning without the burden of hardware ownership.
- It's ideal for startups, enterprises, and development teams seeking **cost-efficient scaling**, **business agility**, and **strong availability**.
- IaaS supports modern DevSecOps workflows, hybrid cloud models, and infrastructure automation using tools like **Terraform**, **AWS CloudFormation**, and **Ansible**.

---

###  Security Implications

- Using IaaS allows Applications teams to adopt infrastructure that supports containerized apps (e.g., in EKS).
- By offloading patching and hardware maintenance to AWS, the **security team can focus on workload-level hardening** (like IAM policies, pod security, and CI/CD pipeline enforcement).
- **AWS Shield**, **Security Hub**, and **GuardDuty** provide enhanced threat detection over this infrastructure layer.
