# IaC Fundamentals with Azure Bicep
This project contains Infrastructure as Code (IaC) examples using Azure Bicep. The examples in this repository are intended to help you get started with Azure Bicep and demonstrate best practices for managing infrastructure on Azure.

## Repository Structure
``` csharp
iac-fundamentals-oreilly/
│
├── .github/
│   └── workflows/
│       └── workflow.yml
│
├── modules/
│   ├── database.bicep
│   ├── networking.bicep
│   ├── subscription-scoped.bicep
│   └── webApp.bicep
│
├── scripts/
│   └── deployToSubscription.ps1
│
├── src/
│   ├── main.bicep
│   └── multi-scoped.bicep
│
├── README.md
└── .gitignore

```

- `.github/workflows/:` GitHub Actions workflows for CI/CD.
- `modules/`: Contains Bicep libraries (modules) for deployments\
- `scripts/`: PowerShell scripts for deploying Bicep templates to Azure.
- `src/`: Contains the Bicep templates.
- `README.md`: This file.

## Prerequisites
To work with the Bicep files in this repository, you'll need:

- Azure CLI: Install the Azure CLI and log in with az login.
- Bicep CLI: (Installing the Azure CLI already installs Bicep).
- PowerShell Core: Install PowerShell Core if you haven't already.

## Getting Started
### Cloning the Repository
Clone this repository to your local machine:
```
git clone https://github.com/AdoraNwodo/iac-fundamentals-oreilly.git
cd iac-fundamentals-oreilly
```

### Deploying Bicep Templates
You can deploy Bicep templates using the provided PowerShell scripts.

```
pwsh ./scripts/deployToSubscription.ps1
```

