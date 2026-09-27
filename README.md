
---

# PRODUCT MANAGEMENT PORTFOLIO

## Kubernetes Self-Service Provisioning & Telco Cloud

**Product Owner:** Bhagyalakshmi Duraisamy

This portfolio demonstrates technical product management
across Kubernetes lifecycle automation, Linux self-service
provisioning, infrastructure modernization and proposed
VMware Telco Cloud capabilities.

## Product Documentation

| Document | Description |
|---|---|
| [Architecture](docs/architecture.md) | Kubernetes fundamentals, architecture and implementation |
| [Experiments](docs/experiments.md) | Hands-on Kubernetes tests and evidence |
| [Gap Analysis](docs/gap-analysis.md) | Current prototype versus enterprise target |
| [Linux Roadmap & BVI](docs/linux-roadmap-bvi.md) | Product roadmap and illustrative prioritization |

## Product Requirements Documents

| PRD | Scope |
|---|---|
| [Linux Kubernetes PRD](docs/linux-prd.md) | Self-service provisioning, user stories, acceptance criteria and KPIs |
| [Telco Cloud PRD](docs/telco-cloud-prd.md) | Network workloads, edge orchestration and carrier-grade requirements |

## Product Strategy

**Vision:** Standardize Kubernetes infrastructure
provisioning and workload lifecycle management,
reducing manual operations and enabling developer
self-service.

**Product approach:**
- Define customer problems and product requirements.
- Prioritize features using an illustrative BVI model.
- Translate requirements into an incremental roadmap.
- Validate capabilities through hands-on experiments.
- Identify gaps between local prototypes and
  enterprise infrastructure requirements.

## Implementation Status

| Capability | Status |
|---|---|
| Local kind cluster provisioning | Tested |
| Linux workload deployment | Tested |
| Workload scaling | Tested |
| Successful rolling upgrades | Tested |
| Automatic rollback | Final log verification pending |
| Self-service portal | Planned |
| VMware Tanzu integration | Planned |
| Telco Cloud integration | Proposed |

## Technology

Kubernetes · Docker Desktop · kind · kubectl ·
Linux · Bash · YAML · Git · GitHub

**Planned:** VMware Tanzu, RBAC, CI/CD,
Prometheus, Grafana and self-service APIs.

## Project Scope

Local Kubernetes experiments demonstrate
the implemented prototype.

The Linux enterprise roadmap and Telco Cloud PRD
describe proposed future capabilities. They do not
represent completed VMware deployments.

---

## Data Confidentiality Notice

This repository is an independent portfolio project.
Any customer scenarios, business metrics, BVI scores
and example datasets are synthetic or illustrative
and provided for demonstration purposes only.

Kubernetes experiment results and screenshots reflect
actual testing in a local development environment.
No production VMware Tanzu deployment is claimed.

---

## UX Wireframe

Designed a six-screen Kubernetes self-service portal wireframe covering the dashboard, cluster requests, Linux deployment, workload scaling, rolling upgrades and deployment history.

**[View Kubernetes Self-Service UX Wireframe (PDF)](docs/wireframes/kubernetes-wireframe-portfolio.pdf)**

