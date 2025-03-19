# Cloud Resources Demo with Crossplane

This repository demonstrates how to manage AWS cloud resources like S3 buckets and RDS instances using Crossplane deployed through the Replicated platform.

## Overview

This application enables you to:

1. Install Crossplane with AWS provider configurations
2. Deploy and manage AWS resources including S3 buckets and RDS databases
3. Package everything as a Replicated app for easy distribution to customers

## Architecture

The application consists of two main Helm charts:

### 1. cloud-providers
This chart installs and configures AWS Crossplane providers:
- AWS S3 provider for object storage
- AWS RDS provider for managed databases
- Appropriate provider configurations with AWS credentials

### 2. cloud-resources
This chart creates and manages actual AWS resources:
- S3 buckets with configurable versioning and encryption
- RDS database instances with configurable parameters
- Custom resource definitions for object storage

## Prerequisites

- Kubernetes cluster 1.26+
- Replicated KOTS or Embedded Cluster for installation
- AWS account with appropriate permissions

## Installation Options

The application can be installed via:

1. **Replicated KOTS**: Using the Replicated admin console 
2. **Embedded Cluster**: Using Replicated's lightweight Kubernetes distribution
3. **Existing Cluster**: Deploy to an existing Kubernetes cluster

## Configuration

During installation, you'll need to provide:

- AWS Access Key ID and Secret Access Key
- AWS Region
- Optional S3 bucket and RDS instance configurations

The application will create resources with names based on your license information and configuration.

## Troubleshooting

The application includes built-in troubleshooting capabilities:

- Preflight checks to validate prerequisites
- Support bundle collection for easy diagnostics
- Runtime status monitoring for AWS resources

## Development

To modify or extend this application:

1. Clone this repository
2. Modify the Helm charts in the `charts/` directory
3. Update the Replicated manifests in the `replicated/` directory
4. Use the provided Makefile to build and release your changes

```bash
# Build and package the Helm charts
make charts

# Lint the release
make lint

# Create a release on the Replicated platform
make release
```

## Contributing

Contributions are welcome! Please submit pull requests with any improvements or bug fixes.
