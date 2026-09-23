# Mavencrest Azure Landing Zone

Enterprise-style deployment of a multi-subscription Azure environment using the Microsoft Azure Landing Zones (ALZ) Infrastructure as Code Accelerator, Terraform, and Azure DevOps.

## Business Problem

The project provides a standardized way to provision and govern Azure subscriptions for new teams, departments, applications, and environments without rebuilding security, networking, policy, and access controls each time.

Common use cases include:

- Onboarding a new department with governed Azure subscriptions
- Creating separate dev, test, and prod subscriptions for an application team
- Integrating a newly acquired business unit into an existing Azure governance model

## Platform and Workload Model

The environment separates shared platform services from application workloads.

The platform layer provides management groups, Azure Policy, centralized monitoring, security structure, hub networking, Terraform state, and deployment infrastructure.

The production workload layer uses a dedicated subscription with its own spoke VNet, application and database subnets, Network Security Groups (NSGs), and bidirectional hub-and-spoke peering.

The shared platform foundation was deployed using the ALZ Accelerator and customized through Terraform.

Terraform state is centrally stored in Azure Storage, with separate state files for platform and workload infrastructure.

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
## Governance

Subscriptions inherit policy and access controls through the management group hierarchy.

Azure Policy actively enforces platform standards. For example, `Deny-Subnet-Without-Nsg` blocked creation of a workload subnet until a Network Security Group was included in the Terraform configuration.

## Deployment Workflow

Feature branch
→ Pull Request
→ Required Terraform plan validation
→ Review
→ Merge to main
→ Production apply pipeline
→ Manual approval
→ Terraform apply
→ Azure

## Repository Structure

alz-mgmt
→ Shared platform configuration and governance

alz-mgmt-templates
→ Shared Azure DevOps pipeline templates

alz-workload-prod
→ Production workload landing zone infrastructure

mavencrest-landing-zone
→ Project documentation, architecture, and bootstrap history
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

## Future Additions

PIM, Defender for Cloud, Azure Firewall, Private DNS, DDoS Protection, multi-region disaster recovery, self-service subscription vending, and additional workload landing zones.
