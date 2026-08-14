---
title: "Production Self-Hosting of Dify on GCP with Terraform"
summary: "Deploy a production-oriented self-hosted Dify environment on Google Cloud using Terraform."
date: 2025-05-24
lastmod: 2025-05-24
tags: ["Terraform", "Dify"]
draft: false
showSummary: true
---

## 1. Introduction
This article describes how to self-host dify, which allows you to easily create AI applications on WEBUI, on Google Cloud Platform (GCP) using terraform.

### What you can do with this article
- Self-hosting dify on gcp using terraform

### Who is this article for?
- Those who want to easily publish AI applications externally
- Those who want to operate dify not only locally but also in the cloud

### Operating environment
-OS version
    - MacOS Sequoia 15.5

## Advance preparation
### Clone the repository
When hosting dify with gcp, there is a repository below that publishes configuration files for terraform, which automates infrastructure construction on the cloud, so clone it.

```sh
git clone https://github.com/DeNA/dify-google-cloud-terraform
```

### Installing packages
#### Installing terraform
```sh
brew install terraform
```

#### Installing google cloud sdk
```sh
brew install --cask google-cloud-sdk
```

### Create gcp project
Create a project with any name from the console.
I will omit the details.

### Login to gcp from cli
```sh
gcloud auth login
```
After entering the command, a web page will open and you can log in.

## Create a bucket for storing tfvars
Create storage for managing terraform state in the cloud
Select buckets from the GCP console.
Create a bucket with any name

## Modify the file
Modify the repository you cloned earlier and customize it for yourself.
### Fix gitignore
Add to gitignore to prevent confidential information from being uploaded remotely
```text:.gitignore
terraform.tfvars
```

*terraform/environments/dev
The
*terraform/environments/prod
Copy it with the name.

### Modification of provider.tf
Apply the bucket you created earlier to terraform state management
```diff_terraform:provider.tf
terraform {
  backend "gcs" {
+   bucket = "<バケットの名前>"
    prefix = "dify"
  }
}
```

### Fixed tfvars
Modify terraform.tfvars in the copied prod
Regarding the key,

```sh
openssl rand -base64 42
```
It would be a good idea to create it by running

```diff_terraform:terraform.tfvars
+ project_id = "例：dify-sample-app"
+ region = "例：asia-northeast1"
+ plugin_daemon_key = "<opensslコマンドで作成>"
+ plugin_dify_inner_api_key = "<opensslコマンドで作成>"
```

## Deploy
Once you've reached this point, it's time to deploy to GCP.

### terraform initialization
```sh
cd terraform/environments/prod
terraform init
```

### Create Artifact Registry repository
```sh
terraform apply -target=module.registry
```

### Build and push container image
```sh
cd ../../..
sh ./docker/cloudbuild.sh <project-id> <region>
```

### terraform planning
```sh
cd terraform/environments/dev
terraform plan
```

### Apply terraform
```sh
terraform apply
```

## Attention
API-related errors may occur while applying terraform. In that case, follow the error message and enable the necessary APIs.
Just press the enable button from the GCP console

## Reference materials
<!--

https://qiita.com

[Link 1](https://qiita.com)
-->

https://github.com/DeNa/dify-google-cloud-terraform


<!--
## おわりに・まとめ
どちらかを書きます。あってもなくても良いです。
-->

---

[Read the original article on Qiita](https://qiita.com/daigo-suhara/items/ff3e627c882adcb6c814)
