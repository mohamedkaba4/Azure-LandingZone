# Project Playbook

# Azure Landing Zone — Runbook

## Adding Resources

All infrastructure changes are managed through **Terraform and Azure DevOps CI/CD**.

### 1. Select the correct repository
- **Platform:** Hub networking, management, security, and shared services.
- **Workload:** Application VNets, subnets, peering, and workload infrastructure.

Internet-facing workload subscriptions belong under the **Online** management group.

### 2. Create a feature branch

```bash
git checkout main
git pull
git checkout -b feature/add-resource
```

### 3. Modify and validate Terraform

Add resources using existing modules, providers, naming conventions, and tags.

```bash
terraform fmt -recursive
terraform init
terraform validate
terraform plan -var-file="prod.tfvars"
```

Run from the appropriate Terraform directory and adjust the variable-file path as needed.

### 4. Submit a pull request

```bash
git add .
git commit -m "feat: add infrastructure resources"
git push -u origin feature/add-resource
```

Create a PR targeting `main`, review CI checks and the Terraform plan, then merge.

### 5. Deploy and verify

- Confirm the CD pipeline successfully runs `terraform apply`.
- Verify resources in Azure.
- Check networking, permissions, and configuration.

## Updating or Removing Resources

Follow the same **branch → PR → review → merge → deploy** workflow.

Always review Terraform replacements and deletions before approval.

## AKS Platform Example

1. Add `vnet-mavencrest-platform-prod` and AKS subnets to the Online workload subscription.
2. Configure bidirectional peering with `vnet-hub-eastus-001`.
3. Merge the PR and verify deployment.
4. Update the separate AKS Terraform project to reference the new subnet.
5. Deploy `aks-mavencrest-platform`.

**Rule:** Landing Zone Terraform owns networking; AKS Terraform owns the cluster; Argo CD/Helm manages Kubernetes applications.
