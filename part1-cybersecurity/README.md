## Threat Intelligence Report
Given the breach involved an unpatched web application in Afam financial, several common attack vectors can be exploited. The ability to execute attack controlled code on the Company's network can be used for various purposes, including stealing sensitive finanial data and unauthorized access to financial records. they are as follows:
### Types of possible attacks
- **Remote Code Execution (RCE)** - The attacker can use remote code execution techniques to deploy malware into the network given the exploitable flaws in the security setup. Certain vulnerabilities can be used by RCE namely;
    - File management.
    - Out-of-bounds write.
    - Insecure deserialization.
- **Server-Side request forgery(SSRF)** - Given that this breach came through an unpatched web application, assuming that one of the financial applications accepts user inputs like URL and API endpoints, to make server side requests without proper validation and sanitization, this applcation can be vulnerable to SSRF. 
A common pattern will look like this;
```
url = request.GET['target']
response = requests.get(url)

```
In Afam Financial's case if the assuming the application accepted external urls for any server side processing(API relay, webhook) then SSRF can be exploited. In the context of cloud infrastructure,SSRF is particularly dangerous because it allows attackers to reach internal services, access metadata, and potentially steal temporary cloud credentials. This may allow attackers to; reach internal services, access cloud provider metadata endpoints.

- **SQL Injection and XSS(Cross site scripting)** - In Cross Site Scripting injection data can be included into dynamic content thats sent into the Web user without malicious content validation, this could be in form of the following types;
    - Stored Xss type - stored attacks occur where the script is injected permanently on the target web servers.
    Executed by Server -> Browser
    - Reflected XSS type - With Reflected XSS the injected script is reflected off the web browser such as search results aor responses that would include some or all the input that is sent to the server as part of the request. In this type of XSS the attacks are delivered by another route, via email message. Users can be tricked via social engineering by clicking on a malicious link or browsing on the malicious site presented, the injected code travels to the vulnerable web site, which reflects the attack back to the user’s browser.
    Executed by Server -> Browser
    - DOM(Document Object Model) based attack - In this xss attack the attack payload is executed due to modification of the DOM ont he client side javascript and not the server side, 
    Executed by Browser only.
Furthermore, with SQL Injection attacks, malicious code is inserted into strings (input fields not properly parameterized)that are later passed to an instance of our SQL Server Database Engine for parsing and execution. All our SQL procedures that constructs SQL statements should be reviewed for injection vulnerabilities, considering that Database Engines execute all syntactically valid queries that it receives.

- **Man in the Middle attacks** - With Man in the middle attacks, the attackers are positioned between the client and the web application and could intercept or alter communications. The risk attackers can abuse are below;
    - Weak TLS enforcement on the Web application.
    - DNS Poisoning.
    - Session Hijacking.
    - Compromised WIFI or Proxy.
Once attackers are inside the company's network, they can sniff credentials, impersonate users and modify responses.

## Preventive Measures, to Avoid Future incidents in Afam Financial

### 1. Secure SDLC(Software development lifecycle)
- Scan Secrets
- Shift security left in CI/CD Pipelines by incorporating security into each phase of delivery
    - IAST - Interactive Application Security Testing
    - DAST - Dynamic Application Security Testing
    - RASP - Runtime Application Self-Protection
    - SAST - Static Application Security Testing
- Code Reviews with static analysis tools(Sonarqube, Snyk)
- Dependency Scanning.
These will help in preventing libraries and vulnerable code from being pushed to production during Pull requests and code reviews.

### 2. Enforce PLOP(Principle of Least Privilege(IAM))
To better understand the breach and develop a response strategy, I applied the PLOP framework which evaluates the security risk landscape based on four critical dimensions: Posture, Likelihood, Opportunity, and Prevalence.
- Posture – How resilient was the system?
- Leaks/Opportunity – What doors were left open?
- Prevalence – How common is this kind of breach

### 3. USE AWS WAF
- Deploy AWS WAF for Cloudfront distributions and Application Load Balancers with managed rules for BOT Protection, XSS, SQL injection
- Use AWS shield intandem with AWS WAF so as to avoid DDOS, since the application is exposed to the internet, vulnerable to resource exhaustion

### 4. SSRF Prevention
- Enforcement of IMDSv2 for EC2 metadata access, to leverage IMDSv2, we would be disabling old IMDSv1 should that have used.
- Tighten firewall rules and disable unnecessary outbound traffic with NACLs and egress restrictions
- Inpput validation and whitelisting URLs if the web applcation needs to fectch external resources


### 5. Security Training for Developer Awareness

- Brown bag series, Developer training on secure coding practices and code review scanners and tools
- Cloud Specific training programs
- Threat modelling sessions that target Threat modelling
- Compliance enforcement and awareness trainings

### 6. Use Network Segmentation, Isolate environments 
- AWS Private link can be used tor service to service communicationsas an added layer of security.
- Use Transit Gateways to restrict traffic like EAST-WEST Traffic
- Separate environments tiers with VPCs, Subnets, Security groups

### 7. Routine Security Audits
- Remediate findings from Code scanners and security hub with clear ownership to team members and timelines
- Run penetration tests and set time(quarterly), or after major code changes

### 8. Realtime Alerting and Centralized logging
- Aggregate logs from compute and other infrastructure to Cloudwatch
- Feeds Logs to SIEM tools like DataDog, Splunk
- Enable AWS Guard Duty to detect IAM misuse, port scanning

### 9. Patch Management

- Set up automated patching for EC2 instances and container images through Golden images using(Systems manager - Patch manager) The security breach emanated from a patching vulnerability in Afam Financial, it was a direct avenue for the attacker to exploit known CVEs.
it matters because once a vulnerability is disclosed, adversaries can weaponize it as the current context with Afam financial. Actions should include;
    - Inventory of all assets including containers, instances, codebases, using tools like AWS Systems Manager inventory.
    - Regular vulnerability scans using tools like Checkmarx, Tenable, Wizio, Sonarqube.
    - The unpatched vulnerability in Afam’s environment could have been detected and prioritized by Wiz.io as a Critical Risk.
- Monitor CVEs using tools like AWS Insepctor.
- Track and monitor security assets, vulnerabilities and posture using AWS Security Hub.

## Incident Response Plan


### Identification

+ **Root Cause:** An unpatched  web application in the organization exposed an SSRF vulnerability, allowing unauthorized access to AWS Cloud metadata endpoint ```169.254.169.254``` and leakage of temporaryIAM credentials.
+ **Detection tools:** AWS Guarduty, wiz.io, Cloudtrail, VPC Flowlogs


### Containment

+ We isolated EC2 instances via Security Groups.
+ Emergency WAF rules were applied to clock malicious inputs.
+ S3 access was restricted and known attacker IP ranges where blocked.
+ Rotated IAM keys and Enforced.

## Eradication

+ The team rescanned infrastructue with Amazon Insepctorand other scanning tools.
+ Audit where son on IAM roles and excessive permissions removed.
+ Input validationwas implemented and raw URL handling was disable in code bases.

## Recovery
Post Containment and Eradication, recovery will focus on safely restoring services and verifying system integrity to avoid future recurrence.
+ Rebuild and Redeploy.
+ Hardened Rollout;
+ Post restoration validation.
+ Enhanced Monotoring and Alerting.
+ Regulatory and stakeholder communication; Internal reporting, customer assurance, regulatory notification.


### Action Plan
| Task                                 | Owner              | Deadline |
|--------------------------------------|--------------------|----------|
| Patch SLA policy across app teams    | SecOps             | 30 days  |
| CI/CD pipeline SAST/DAST enforcement | DevSecOps          | 14 days  |
| IAM role re-segmentation             | Infra Team         | 10 days  |
| Organization wide IR simulation      | Security Awareness | 45 days  |


### Recovery Metrics
| Objective                        | Metric                             | Target        |
|----------------------------------|------------------------------------|---------------|
| Time to restore prod             | Mean Time to Recovery (MTTR)       | < 2 hours     |
| Vulnerability reintroduction     | CVE reoccurrence rate              | 0% in 90 days |
| Configuration drift              | Config changes post-rebuild        | ≤ 2% drift    |
| Credential hygiene               | Key rotation completions           | 100% in 1 day |
| Client trust impact              | Support tickets volume             | Baseline      |


## Network Security Recommendations
Here’s how the Development and Security teams need to harden the network layer, implement moving forward to strengthen our defenses and avoid a repeat of the breach:

+  **Intrusion Detection & Prevention;** We should enable Amazon GuardDuty across all regions to automatically alert us to suspicious activity like port scanning, unusual IAM behavior, or possible malware communication.
In addition, we should tighten our WAF (Web Application Firewall) rules to block known attack patterns before they even reach our apps.

+  **Firewalls and Network Access Control;** We need to ensure all Security Groups follow the principle of least privilege — only opening ports that are truly required.

+  **Network Segmentation;** For internal traffic, VPC peering and route tables should control what can talk to what. To go even further, deploying AWS Network Firewall at our VPC boundaries will allow us to inspect traffic at a deeper level and block threats earlier.

+  **Identity & Access Management (IAM) Hardening;** It’s critical that we clean up any over-permissioned IAM roles. We should use IAM Access Analyzer to spot risky access paths and tighten things up.