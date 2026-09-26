---
title: "Metal3.io Maintainer"
summary: "Member of the release team for Metal3.io, a CNCF Incubating Project."
date: 2026-09-26
description: "Open-source maintenance work for the Metal3.io project."
tags: ["Kubernetes", "Metal3", "Go", "Open Source"]
showDate: false
showReadingTime: false
showWordCount: false
---

I am a maintainer of [Metal3.io](https://metal3.io/), an open-source project for managing bare-metal hosts with Kubernetes.

## About Metal3.io

Metal3.io manages physical servers through Kubernetes APIs, from host enrollment and OS image provisioning to Kubernetes cluster deployment and upgrades. Metal3.io itself runs on Kubernetes and uses Kubernetes resources and APIs as its interface.

It also provides the bare-metal implementation for Cluster API, which offers infrastructure-agnostic Kubernetes cluster lifecycle management.

The project was started by Red Hat in 2019, with Ericsson joining later that year. It entered the CNCF Sandbox in September 2020 and advanced to a [CNCF Incubating Project](https://www.cncf.io/blog/2025/08/27/metal3-io-becomes-a-cncf-incubating-project/) in August 2025.

Its main components include Bare Metal Operator (BMO), which exposes parts of the Ironic API as Kubernetes-native APIs; Cluster API Provider Metal3 (CAPM3), which integrates with Cluster API; IP Address Manager (IPAM), which manages addresses and pools; and Ironic Standalone Operator (IrSO), which deploys Ironic on Kubernetes.

## Work

As a member of the release team, I work on component releases and patch fixes.

I review changes and dependencies, prepare release notes, check test results, update packages, and verify published artifacts after each release.

## Contributions

- [OCI image URLs without checksum](https://github.com/metal3-io/cluster-api-provider-metal3/pull/3522)
- [Fix Linux detection for kubectl installation in Leap CI](https://github.com/metal3-io/cluster-api-provider-metal3/pull/3723)
- [Run zizmor for release branch PRs](https://github.com/metal3-io/baremetal-operator/pull/3644)
- [CAPM3 v1.13.5 release](https://github.com/metal3-io/cluster-api-provider-metal3/pull/3760)
- [IPAM v1.13.6 release](https://github.com/metal3-io/ip-address-manager/pull/1642)
