# ADF Pipeline Deployment PoC 🚀
[![ADF_Deployment_Workflow](https://github.com/Aman-PN/ADF_Deployment-PoC/actions/workflows/ADF_Deployment.yml/badge.svg?branch=develop)](https://github.com/Aman-PN/ADF_Deployment-PoC/actions/workflows/ADF_Deployment.yml)

A Proof of Concept implementation for automated Azure Data Factory pipeline deployment using GitHub Actions, supporting multi-environment CI/CD workflows.

## 📌 Overview
This solution demonstrates:
- Automated deployment of ADF pipelines using ARM templates
- Environment-specific configuration management (Dev, Stage, Prod)
- GitHub Actions-powered CI/CD pipeline
- Infrastructure-as-Code (IaC) implementation

<img width="901" height="616" alt="image" src="https://github.com/user-attachments/assets/04e7270c-b55f-425a-9d86-786ec08e7b0f" />

*Sample architecture diagram*

## ✨ Features
- **Multi-stage Deployments**
  - Dev → Stage → Prod promotion workflow
  - Environment-specific parameter injection
  - Automated validation gates

- **CI/CD Automation**
  - GitHub Actions workflow triggers (push/PR/manual)
  - ARM template validation & deployment
  - Pipeline artifact management

- **Security**
  - Azure Service Principal authentication
  - Secrets management via GitHub Actions
  - RBAC-controlled deployment permissions

## 🛠️ Prerequisites
- Azure subscription with Owner permissions
- Existing Azure Data Factory instance
- GitHub repository with Actions enabled
- Azure Resource Group (per environment)
- [ARM Toolkit](https://learn.microsoft.com/en-us/azure/azure-resource-manager/templates/overview) basics

## 🚀 Getting Started

### 1. Repository Setup
1. Clone the repository:
```bash
git clone https://github.com/Aman-PN/ADF_Deployment-PoC.git
cd ADF_Deployment-PoC
```
2. Set up your Azure environment and create the necessary resources.
3. Configure your GitHub repository settings to enable GitHub Actions.

### 2. GitHub Secrets Setup
Configure these secrets in your repo settings:
- `AZURE_CREDENTIALS` - Azure service principal credentials
- `ARM_SUBSCRIPTION_ID` - Target Azure subscription ID
- `ADF_RESOURCE_GROUP` - Base resource group name

## ⚙️ Deployment Workflow

### Pipeline Triggers
```yaml
on:
  push:
    branches: [ develop ]
  pull_request:
    branches: [ develop ]
  workflow_dispatch:
```

### Usage
To deploy your ADF pipelines, push changes to the main branch or create a pull request. The GitHub Actions workflow will automatically trigger and deploy your changes to the specified environment.

## 🔧 Customization
Modify `.github/workflows/deploy.yml` to:
- Add environment-specific variables
- Adjust approval gates
- Modify deployment triggers

## 🤝 Contributing
1. Fork the repository
2. Create feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open Pull Request

## 📄 License
Distributed under MIT License. See `LICENSE` for details.

## 🙏 Acknowledgements
- Azure Resource Manager Templates
- GitHub Actions Marketplace
- Microsoft Learn Documentation
