# ADF Pipeline Deployment PoC 🚀
[![ADF_Deployment_Workflow](https://github.com/Aman-PN/ADF_Deployment-PoC/actions/workflows/Selective_ADF_Deployment_centralized_new.yml/badge.svg?branch=develop)](https://github.com/Aman-PN/ADF_Deployment-PoC/actions/workflows/Selective_ADF_Deployment_centralized_new.yml)

A Proof of Concept implementation for automated Azure Data Factory pipeline deployment using GitHub Actions, supporting multi-environment CI/CD workflows.

## 📌 Overview
This solution demonstrates:
- Automated ARM template deployment for ADF pipelines
- Environment-specific configuration management (Stage/Dev/Prod)
- GitHub Actions-powered CI/CD pipeline
- Infrastructure-as-Code (IaC) implementation

![ADF Deployment Architecture](https://miro.medium.com/v2/resize:fit:1100/format:webp/1*UsUSpZ5DZ3SpraJAFl0TCg.png) 

*Sample architecture diagram*

## ✨ Features
- **Multi-stage Deployments**
  - Stage → Dev → Prod promotion workflow
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
```bash
git clone https://github.com/Aman-PN/ADF_Deployment-PoC.git
cd ADF_Deployment-PoC
```

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

### Deployment Steps
1. **Validate Templates** - ARM template syntax check
2. **Stage Deployment** - Initial validation environment
3. **Dev Promotion** - Manual approval gate
4. **Prod Deployment** - Final production rollout

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
