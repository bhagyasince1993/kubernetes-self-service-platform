# Kubernetes Architecture & VMware Self-Service Provisioning

## 1. Project Overview

This project explores the design and development of a
self-service Kubernetes provisioning platform, with
VMware Tanzu as the target enterprise environment.

The objective is to standardize Kubernetes lifecycle
operations and reduce manual infrastructure management.

### Technology Stack

- Kubernetes
- kubectl
- Docker Desktop
- kind
- Bash
- YAML
- GitHub
- VMware Tanzu Kubernetes Grid (planned)

### Current Environment

- macOS on Apple Silicon
- kubectl v1.37.1
- Docker Desktop v29.8.0
- Local kind cluster: vmware-lab
- Kubernetes cluster: v1.35.0

VMware Tanzu integration is planned. The current
implementation runs on a local kind cluster.

---

# PART I: KUBERNETES FUNDAMENTALS

## 2. What Is Kubernetes?

Kubernetes (K8s) is an open-source container
orchestration platform.

It automates the deployment, scaling, management
and recovery of containerized applications.

Instead of manually managing application containers
across servers, engineering teams declare how an
application should run.

Kubernetes continuously works to maintain that
desired configuration.

### Example

Imagine an enterprise payroll application serving
thousands of customers.

Its infrastructure must support:

- Application availability
- Increasing customer traffic
- Software upgrades
- Failure recovery
- Consistent deployment across environments

Kubernetes helps automate these operations.

---

## 3. Why Do We Need Kubernetes?

Traditional application management often involves
manual deployment, server configuration, scaling
and recovery.

These activities become increasingly difficult
as applications and infrastructure grow.

Kubernetes addresses several challenges.

### 3.1 Automated Deployment

Applications are deployed using declarative
configuration files rather than repeated
manual installation steps.

### 3.2 Scalability

Kubernetes supports horizontal application scaling.

For example, an application can increase from
two replicas to four replicas when additional
capacity is needed.

The Horizontal Pod Autoscaler can automate
replica adjustments using configured metrics.

### 3.3 Self-Healing

Kubernetes can restart failed containers,
replace failed Pods and maintain the desired
number of application replicas.

### 3.4 High Availability

Applications can run across multiple nodes.

With appropriate architecture, replicas and
failure-domain configuration, Kubernetes can
help reduce application downtime.

### 3.5 Rolling Updates

New application versions can be deployed
incrementally instead of replacing every
running instance simultaneously.

### 3.6 Infrastructure Standardization

Development teams can use consistent Kubernetes
deployment patterns across supported environments.

---

## 4. Containers vs. Kubernetes

### Containers

Containers package an application with its
runtime dependencies.

Docker is commonly used to build and run containers.

### Kubernetes

Kubernetes manages containerized applications
across one or more machines.

Docker and Kubernetes solve different problems:

- Docker: Container development and execution
- Kubernetes: Container orchestration
- VMware Tanzu: Enterprise Kubernetes management
  within supported VMware environments

Kubernetes uses compatible container runtimes
such as containerd.

---

# PART II: KUBERNETES ARCHITECTURE

## 5. High-Level Architecture

A Kubernetes cluster consists of a control
plane and worker nodes.

```text
              Developer / Platform User
                        |
                     kubectl
                        |
                 Kubernetes API
                        |
              +-------------------+
              |   CONTROL PLANE   |
              |                   |
              |    API Server     |
              |       etcd        |
              |    Scheduler      |
              | Controller Manager|
              +-------------------+
                        |
           +------------+------------+
           |                         |
    +-------------+           +-------------+
    | Worker Node |           | Worker Node |
    |             |           |             |
    |   kubelet   |           |   kubelet   |
    |   Runtime   |           |   Runtime   |
    |             |           |             |
    |  Pod  Pod   |           |  Pod  Pod   |
    +-------------+           +-------------+
```

This is a conceptual production architecture.

Our current local kind cluster has one
control-plane node that also runs workloads.

---

## 6. Control Plane Components

The control plane manages the Kubernetes
cluster and its desired state.

### 6.1 API Server

The API Server is the primary entry point
for Kubernetes management operations.

It processes requests from:

- kubectl
- Automation scripts
- Management platforms
- Kubernetes controllers

### 6.2 etcd

etcd is a distributed key-value store
that maintains Kubernetes cluster state.

It stores information about cluster
configuration and Kubernetes resources.

### 6.3 Scheduler

The scheduler assigns newly created
Pods to suitable nodes.

Scheduling considers factors such as:

- Resource requirements
- Node availability
- Scheduling constraints
- Affinity and anti-affinity
- Taints and tolerations

### 6.4 Controller Manager

Controllers continuously compare actual
cluster state with desired state.

For example, if a Deployment requires
three replicas but only two are running,
Kubernetes attempts to create another Pod.

---

## 7. Worker Node Components

Worker nodes execute application workloads.

### 7.1 kubelet

The kubelet ensures that containers
specified in Pod definitions are running.

### 7.2 Container Runtime

The container runtime executes containers.

Examples include containerd and CRI-O.

### 7.3 kube-proxy

kube-proxy implements Kubernetes Service
networking where the selected networking
architecture uses it.

### 7.4 Pods

Pods are the smallest deployable units
in Kubernetes.

A Pod contains one or more containers
that share networking and storage resources.

---

## 8. Core Kubernetes Objects

### Cluster

A collection of Kubernetes nodes
managed as one environment.

### Node

A physical or virtual machine
that runs Kubernetes components.

### Namespace

A logical grouping of Kubernetes resources.

Namespaces help organize applications,
teams and environments.

### Pod

The smallest deployable Kubernetes unit.

### Deployment

Defines and manages application replicas,
rolling updates and rollout history.

### ReplicaSet

Maintains the requested number of
matching Pods.

### Service

Provides a stable network endpoint
for accessing application workloads.

### ConfigMap

Stores non-sensitive application configuration.

### Secret

Stores sensitive configuration data.

Additional encryption and access controls
may be required for production security.

### PersistentVolume

Provides persistent storage independently
of an individual Pod's lifecycle.

### Horizontal Pod Autoscaler

Adjusts workload replica counts based
on configured resource or custom metrics.

---

# PART III: SELF-SERVICE PLATFORM

## 9. What Is Self-Service Provisioning?

Self-service provisioning allows users
to request standardized infrastructure
or application environments without
manually executing every infrastructure
management command.

A platform can expose predefined
configuration options and automate
the underlying Kubernetes operations.

### Example Workflow

```text
        User Requests Environment
                   |
          Validate Configuration
                   |
          Provision / Select Cluster
                   |
            Deploy Workload
                   |
             Health Checks
                   |
            Scale as Needed
                   |
             Upgrade Safely
                   |
           Rollback on Failure
                   |
             Resource Cleanup
```

The current project implements selected
workload lifecycle operations.

A complete self-service interface and
VMware cluster provisioning remain planned.

---

## 10. Why VMware Tanzu?

VMware Tanzu provides Kubernetes-related
capabilities for supported VMware
infrastructure environments.

For organizations already operating
VMware infrastructure, Tanzu can support
standardized Kubernetes cluster management.

Potential enterprise requirements include:

- Cluster provisioning
- Configuration standardization
- Cluster lifecycle management
- Access control
- Policy enforcement
- Workload management
- Monitoring and operational visibility

Actual capabilities depend on the
VMware Tanzu product and version.

---

# PART IV: LOCAL IMPLEMENTATION

## 11. Development Architecture

```text
                  Mac
                   |
             Docker Desktop
                   |
              kind Cluster
              "vmware-lab"
                   |
          Kubernetes v1.35.0
                   |
          self-service Namespace
                   |
           nginx-demo Deployment
                   |
               NGINX Pods
```

kind runs Kubernetes nodes as containers.

It provides a convenient environment
for developing and testing Kubernetes
workload automation locally.

It does not replace VMware Tanzu
cluster-management testing.

---

## 12. Environment Setup

### Install kubectl

kubectl is the Kubernetes command-line
interface.

It communicates with the Kubernetes
API Server.

### Install Docker Desktop

Docker Desktop provides the local
container environment required by kind.

### Install kind

kind creates local Kubernetes clusters
using containers as Kubernetes nodes.

### Create the Local Cluster

```bash
kind create cluster \
  --name vmware-lab \
  --wait 5m
```

### Verify Cluster

```bash
kubectl config use-context kind-vmware-lab
kubectl get nodes
kubectl cluster-info
```

Completed result:

- Cluster: vmware-lab
- Kubernetes: v1.35.0
- Control-plane node: Ready

---

## 13. Linux Workload Deployment

Created a dedicated namespace:

```bash
kubectl create namespace self-service
```

Deployed NGINX with two replicas:

```bash
kubectl create deployment nginx-demo \
  --image=nginx:stable \
  --replicas=2 \
  -n self-service
```

Verified deployment:

```bash
kubectl rollout status \
  deployment/nginx-demo \
  -n self-service
```

Both replicas successfully reached
Running status.

Created a reusable declarative
deployment manifest:

manifests/linux/nginx-deployment.yaml

---

## 14. Automated Scaling

Initially scaled the NGINX workload
from two to three replicas.

Created a reusable shell script:

scripts/scale-cluster.sh

Tested the script with four replicas:

```bash
./scripts/scale-cluster.sh \
  self-service nginx-demo 4
```

Observed result:

- Scaling request accepted
- Rollout completed successfully
- Four NGINX Pods reached Running status

This validates workload scaling,
not Kubernetes worker-node scaling.

---

## 15. Declarative Deployment Automation

Created:

scripts/deploy-workload.sh

The script:

1. Creates or configures the namespace.
2. Applies the deployment manifest.
3. Waits for the deployment rollout.
4. Displays application Pod status.

Test command:

```bash
./scripts/deploy-workload.sh self-service
```

Observed result:

- Deployment configuration applied
- Rolling deployment completed
- Three new NGINX replicas became healthy

Kubernetes initially displayed warnings
about missing last-applied-configuration
annotations because the resources were
originally created imperatively.

kubectl automatically patched the
required annotations.

---

## 16. Automated Workload Upgrades

Created:

scripts/upgrade-workload.sh

The script updates the application
container image and monitors rollout
completion.

It also includes rollback logic
for unsuccessful deployments.

Successful upgrade test:

```bash
./scripts/upgrade-workload.sh \
  self-service nginx-demo nginx:1.28
```

Observed result:

- Image update accepted
- Rolling deployment completed
- Upgrade reported success

This validates an application upgrade,
not a Kubernetes cluster upgrade.

---

## 17. Failure Recovery Testing

Initiated an invalid-image test:

```bash
./scripts/upgrade-workload.sh \
  self-service \
  nginx-demo \
  nginx:invalid-test-tag
```

The invalid image is expected to
cause an image-pull failure.

The script is designed to detect
an unsuccessful rollout and attempt
a rollback.

Test status:

Rollback outcome has not yet been
confirmed.

Do not classify automatic recovery
as validated until the final test
output and restored replicas are verified.

---

# PART V: REPOSITORY STRUCTURE

## 18. Project Files

```text
kubernetes-self-service-platform/
|
|-- README.md
|
|-- docs/
|   |-- architecture.md
|
|-- manifests/
|   |-- linux/
|   |   |-- nginx-deployment.yaml
|   |
|   |-- windows/
|
|-- scripts/
    |-- provision-cluster.sh
    |-- scale-cluster.sh
    |-- upgrade-cluster.sh
    |-- delete-cluster.sh
    |-- deploy-workload.sh
    |-- upgrade-workload.sh
```

The Linux deployment, scaling and
workload upgrade scripts have been tested.

Cluster provisioning, cluster upgrades,
cluster deletion and Windows workloads
require further implementation and testing.

---

# PART VI: VMWARE TANZU ROADMAP

## 19. Planned VMware Integration

### Phase 1: Local Prototype

- Kubernetes fundamentals
- Local cluster creation
- Linux workload deployment
- Workload scaling
- Rolling application upgrades
- Rollback validation

### Phase 2: Lifecycle Automation

- Configurable deployment templates
- Parameter validation
- Automated health checks
- Controlled workload cleanup
- Error handling and logging

### Phase 3: VMware Tanzu

- Identify the Tanzu product and version
- Evaluate vSphere prerequisites
- Define cluster configuration templates
- Implement cluster provisioning
- Implement worker-node scaling
- Implement cluster upgrades
- Add controlled cluster deletion

### Phase 4: Windows Workloads

- Evaluate Windows worker-node requirements
- Define compatible Windows container images
- Configure scheduling and node selectors
- Validate Windows application deployment

### Phase 5: Self-Service Experience

- Standardized provisioning requests
- Configuration validation
- Workflow orchestration
- Operational dashboards
- Audit logging
- Role-based access control

---

# PART VII: TECHNICAL PRODUCT MANAGEMENT

## 20. Product Problem

Manual Kubernetes provisioning and
application lifecycle operations can
create operational overhead.

Inconsistent configurations and
repetitive manual procedures may
increase deployment time and risk.

A standardized self-service platform
aims to simplify these activities.

## 21. Product Objectives

- Reduce manual provisioning steps
- Standardize Kubernetes configurations
- Simplify application deployment
- Improve operational consistency
- Support controlled upgrades
- Enable repeatable lifecycle automation

## 22. Proposed Success Metrics

Potential product KPIs include:

- Cluster provisioning lead time
- Workload deployment success rate
- Mean time to recovery
- Upgrade success rate
- Rollback success rate
- Manual intervention per deployment
- Self-service adoption
- Infrastructure utilization

These are proposed metrics, not
measured project outcomes.

## 23. Current Project Status

Completed and demonstrated:

- GitHub repository setup
- Local Kubernetes cluster creation
- Linux workload deployment
- Workload scaling
- Declarative deployment
- Successful rolling application upgrade

Implemented but awaiting validation:

- Automatic rollback on failed upgrades

Planned:

- VMware Tanzu integration
- Cluster lifecycle automation
- Windows workload deployment
- Self-service interface
- Production-oriented monitoring
