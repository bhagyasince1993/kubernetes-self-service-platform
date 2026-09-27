# Product Requirements Document
## Linux Kubernetes Self-Service Provisioning

**Status:** Portfolio prototype / Proposed product
**Platform:** Kubernetes, Linux, VMware Tanzu (planned)
**Product Owner:** Bhagyalakshmi Duraisamy

---

## 1. Product Vision

Enable developers to provision, deploy, scale, upgrade
and manage standardized Linux Kubernetes environments
through a self-service platform.

## 2. Problem Statement

Manual Kubernetes provisioning creates repetitive
operational work, inconsistent configurations and
dependencies on platform engineering teams.

Developers need a standardized way to request
environments and manage workloads.

## 3. Target Users

| Persona | Primary Need |
|---|---|
| Developer | Provision and deploy applications |
| Platform Engineer | Standardize infrastructure |
| SRE | Monitor reliability and recovery |
| Security Administrator | Enforce access policies |

## 4. Product Goals

- Reduce manual provisioning steps.
- Standardize Linux deployment configurations.
- Automate workload lifecycle management.
- Improve deployment reliability.
- Introduce developer self-service.
- Prepare for future VMware Tanzu integration.

## 5. Functional Requirements

| ID | Requirement | Acceptance Criteria |
|---|---|---|
| LNX-01 | Cluster provisioning | Create a cluster and verify node readiness |
| LNX-02 | Deployment | Deploy a Linux workload from YAML |
| LNX-03 | Scaling | Change replica count and verify readiness |
| LNX-04 | Upgrade | Perform rolling upgrades |
| LNX-05 | Recovery | Restore the previous healthy release after failure |
| LNX-06 | Cleanup | Delete selected workloads safely |
| LNX-07 | Self-service | Request environments through an API or portal |
| LNX-08 | Governance | Apply RBAC and resource quotas |
| LNX-09 | Monitoring | Expose workload health and operational metrics |

## 6. User Stories

### US-01: Provision an Environment

As a developer, I want to request a standard Linux
Kubernetes environment so that I can deploy without
manually configuring infrastructure.

Acceptance criteria:
- Validate request parameters.
- Detect existing clusters.
- Provision the requested environment.
- Verify cluster readiness.
- Report provisioning status.

### US-02: Deploy an Application

As a developer, I want to deploy a Linux application
using a reusable template.

Acceptance criteria:
- Accept a valid deployment manifest.
- Create the workload in the selected namespace.
- Wait for successful rollout.
- Report failures.

### US-03: Scale an Application

As a developer, I want to adjust application replicas
to accommodate changes in demand.

Acceptance criteria:
- Accept a valid replica count.
- Update the deployment.
- Verify that the requested replicas become ready.

### US-04: Upgrade and Recover

As an SRE, I want controlled application upgrades
with recovery from failed deployments.

Acceptance criteria:
- Perform a rolling update.
- Detect rollout failure.
- Restore the previous healthy version.
- Capture the final rollout status.

### US-05: Govern Access

As a security administrator, I want role-based access
and resource limits for shared environments.

Acceptance criteria:
- Restrict actions by role.
- Apply namespace resource quotas.
- Record important lifecycle operations.

## 7. Current Prototype vs. Planned Features

| Capability | Status |
|---|---|
| Local kind provisioning | Tested |
| Linux NGINX deployment | Tested |
| Manual workload scaling | Tested |
| Successful rolling upgrade | Tested |
| Automatic rollback | Requires final log verification |
| Self-service portal | Planned |
| RBAC and quotas | Planned |
| Monitoring dashboards | Planned |
| VMware Tanzu provisioning | Planned |

## 8. Non-Functional Requirements

- Reliability: verify readiness after lifecycle operations.
- Security: validate inputs and restrict access.
- Observability: expose deployment and failure status.
- Maintainability: use reusable configuration templates.
- Recoverability: test failed-upgrade recovery.
- Portability: separate local kind logic from future
  VMware Tanzu integrations.

## 9. Dependencies

- Docker Desktop and kind for the local prototype.
- kubectl and deployment manifests.
- A compatible VMware environment for Tanzu testing.
- Identity and authorization integration for
  enterprise self-service.

## 10. Release Plan

### MVP: Local Lifecycle Automation
Provisioning, deployment, scaling, upgrade,
rollback verification and cleanup.

### Release 2: Developer Self-Service
Reusable templates, request API, portal and CI.

### Release 3: Enterprise Controls
RBAC, quotas, monitoring, audit logs and autoscaling.

### Release 4: VMware Tanzu
Supported provisioning integration, cluster lifecycle
management and end-to-end validation.

## 11. Proposed Success Metrics

| KPI | Measurement |
|---|---|
| Provisioning time | Request to ready cluster |
| Deployment success rate | Successful / total deployments |
| Recovery time | Failure detection to healthy rollout |
| Manual effort | Number of manual steps per deployment |
| Self-service adoption | Requests completed without engineer intervention |
| Upgrade success rate | Successful / total upgrades |

Baseline and target values will be established through
actual testing.

## 12. Out of Scope for Initial MVP

- Windows workloads.
- Production VMware Tanzu provisioning.
- Multi-region disaster recovery.
- Enterprise billing and chargeback.

## 13. Evidence

See [Experiments](experiments.md),
[Gap Analysis](gap-analysis.md) and
[Linux Roadmap and BVI](linux-roadmap-bvi.md).

This PRD separates demonstrated local functionality
from proposed enterprise capabilities.
