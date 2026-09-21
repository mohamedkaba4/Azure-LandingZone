# Mavencrest Azure Landing Zone

Deployment of a multi-subscription Azure environment using the Azure Landing Zones Infrastructure as Code (IaC) Accelerator. The accelerator bootstraps the platform by creating Azure DevOps repositories, pipelines, and Terraform configuration that manage governance, security, networking, and workload deployment across the environment.

## Business Problem

As Azure environments grow, managing many different subscriptions, networking, security, policies, and access manually becomes difficult to scale and govern consistently. This project creates a standardized Azure foundation that:

- Organizes subscriptions using management groups
- Applies centralized governance with Azure Policy
- Separates platform and application workloads
- Centralizes monitoring and adds resource visibility
- Provides shared hub networking for future subscriptions and resources
- Uses Terraform and Azure DevOps for controlled infrastructure changes
- Reduces manual portal configuration (prone to human error) and configuration drift


The project provides a standardized way to provision and govern Azure subscriptions for new teams, departments, applications, and environments without manually rebuilding security, networking, policy, and access controls each time.

Real-world use cases:
- a new department like Finance, Engineering, or Data getting its own governed subscription set
- onboarding a new application team that needs separate dev, test, and prod subscriptions
- a newly acquired business unit that needs to be integrated into the company’s Azure governance model

## Platform and Workload Model
AWS multi-account landing zone designed to provide secure, scalable, and governed cloud environments using Infrastructure as Code.

It has a shared platform layer for management groups, policies, monitoring, security, and hub networking, plus a separate production workload repo for the prod spoke VNet, subnet, NSG, and hub-spoke peering. (Deployed with ALZ Accelerator working as a template)

Terraform state is centrally stored in Azure Storage, with separate state files for the platform and workload environments. Azure Policy is actively enforcing standards, and CI/CD is being set up with separate plan and apply identities using workload identity federation and least-privilege RBAC.

## Architecture

```text
Microsoft Entra ID Tenant
│
└── Mavencrest
    │
    └── Azure Landing Zones
        │
        ├── Platform (centralized foundation)
        │   │
        │   ├── Connectivity
        │   │   └── sub-mavencrest-connectivity
        │   │       └── Hub Virtual Network
        │   │
        │   ├── Management
        │   │   └── sub-mavencrest-management
        │   │       ├── Log Analytics
        │   │       ├── Data Collection Rules
        │   │       └── Monitoring resources
        │   │
        │   ├── Identity
        │   │
        │   └── Security
        │       └── sub-mavencrest-security
        │
        ├── Landing Zones (application and workload resources)
        │   ├── Corp
        │   ├── Online
        │   └── Local
        │
        ├── Sandbox (isolated for experiments and testing)
        │
        └── Decommissioned (inactive subscriptions)
```
## Deployment Workflow

Infrastructure changes follow a Git-based workflow:

```text
Feature branch
→ Pull Request
→ CI: terraform validate / plan
→ Review
→ Merge to Main 
→ CD: terraform apply
→ Azure
```
Changes must go through a Pull Request (PR) and validation process before deployment.

## Azure DevOps Structure
```text
alz-mgmt (primarily used after bootstrapping phase)
└── Landing Zone Terraform and platform configuration
Source of truth for the deployment platform

alz-mgmt-templates
└── Shared CI/CD pipeline templates
```

#Workload deployment workflow

```
Subscription creation 
(manual or Terraform)
↓
Terraform subscription placement
↓
Landing Zones > selected management group 
↓
Terraform workload configuration
├── Resource groups
├── Spoke VNet
└── Hub/spoke peering
        ↓
Azure DevOps CI
├── Validate
└── Terraform plan
        ↓
Review / approval
        ↓
Azure DevOps CD
        ↓
Terraform apply
```
Infrastructure changes are deployed through feature branches, pull Requests, Terraform plan/ apply, and an approval-controlled pipeline.

Key Technologies
Azure Landing Zones Accelerator
Terraform
Azure DevOps
Azure Repos
Azure Pipelines
Microsoft Entra ID
Azure Policy
Azure Monitor
Log Analytics
Hub-and-spoke networking
Workload Identity Federation
