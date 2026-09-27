# Kubernetes Platform Components

This role installs and configures the Kubernetes components used by my home lab.

The role currently manages:

* [AWX](https://github.com/ansible/awx-operator) through the AWX Operator Helm chart.
* [Argo CD](https://argo-cd.readthedocs.io/) through its Helm chart.
* [Envoy Gateway](https://gateway.envoyproxy.io/) for HTTP/HTTPS routing.
* [cert-manager](https://cert-manager.io/) for certificate management.
* A small private CA used by the home lab.
* Gateway API resources and application-specific HTTPRoutes.

> [!NOTE]
> Setting a component's corresponding `install` variable to `false` will remove the resources managed by this role, including the Helm release and associated Kubernetes configuration where applicable.

## Why This Role Exists

This is a home-lab project, not a production Kubernetes platform.

I intentionally chose to manage these components through Ansible rather than adopting a more conventional GitOps workflow or introducing additional tooling solely for managing the cluster itself. The goal is to keep the entire environment reproducible from a relatively small amount of configuration while also giving me an opportunity to learn and demonstrate Ansible, Kubernetes, Helm, Gateway API, and related technologies.

For example, Argo CD is itself a GitOps tool, so using Ansible to install and configure Argo CD may seem somewhat backwards. That is intentional. Ansible is the source of truth for building the underlying home-lab environment, while Argo CD is being deployed as one of the applications within that environment.

This approach is not intended to represent a universal best practice. It is a deliberate tradeoff for this particular lab.

## Design Goals

The role is designed around a few simple goals:

* Keep the home-lab environment reproducible.
* Keep configuration in Git.
* Make repeated playbook runs idempotent.
* Avoid unnecessary removal and reinstallation of software.
* Keep variables explicit and readable.
* Make the resulting environment easy to tear down and recreate.

## Role Variables

The primary configuration is in `defaults/main.yml`.

Each component has an `install` variable that controls whether it should be managed by the role. Component-specific variables control namespaces, Helm releases, chart versions, service names, hostnames, certificates, and other configuration.

Some examples include:

```yaml
operators_install_awx: true
operators_install_argocd: true
operators_install_envoy_gateway: true
operators_install_cert_manager: true
```

The role also consumes variables provided by the `kind` role, most notably the path to the installed `kubectl` and Helm binaries.

The complete list of configurable variables is maintained in `defaults/main.yml` so that the defaults remain visible alongside the implementation.

## Dependencies

This role depends on the `kind` role.

The `kind` role provides the Kubernetes cluster and the client tools used by this role, including `kubectl` and Helm.

## Idempotence and Upgrades

The role attempts to distinguish between **installing something for the first time** and **updating an existing installation**.

Where possible, changes to versions or configuration should result in an update rather than an unnecessary uninstall/reinstall cycle.

This is particularly important for components such as AWX and Argo CD where the Kubernetes resources they manage may have state that should not be discarded simply because the playbook is being run again.

The role therefore uses checks, Helm upgrades, Kubernetes resource comparisons, and conditional tasks rather than treating every playbook execution as a fresh installation.

## Scope

This role is intentionally specific to this home lab.

It is not intended to be a generalized Kubernetes platform role or a drop-in solution for other environments. The variables and tasks are kept explicit because the primary goals are reproducibility, maintainability, and learning rather than maximum portability.
