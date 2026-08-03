# Target Architecture

## Management Groups

- mg-mavencrest
  - mg-platform
    - mg-management
    - mg-connectivity
    - mg-identity
  - mg-landing-zones
    - mg-online
    - mg-corp
  - mg-sandbox
  - mg-decommissioned

## Initial Policies

- Require environment tag
- Require owner tag
- Restrict deployments to approved regions
- Audit public storage access
- Audit missing diagnostic settings

## Subscription Placement

- Management subscription -> mg-management
- Connectivity subscription -> mg-connectivity
- Mavencrest development -> mg-online
- Mavencrest production -> mg-online
- Sandbox subscription -> mg-sandbox

## RBAC Model

- Platform owners
- Network contributors
- Security readers
- Workload contributors
