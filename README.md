# 🌩️ Cloud Resources Demo

A comprehensive solution for managing AWS cloud resources including S3 buckets and RDS instances through Kubernetes using Crossplane.

## 📋 Summary

This project demonstrates how to provision and manage cloud resources like S3 buckets and RDS databases using Kubernetes with Crossplane. It's packaged as a Replicated application, allowing easy distribution to customers through the Replicated platform with options for:

- Embedded Cluster deployment (Kubernetes-in-a-box)
- Existing Kubernetes cluster installation
- Air-gapped environments support

The solution uses Helm charts to deploy and configure Crossplane providers and resources, with a straightforward UI for configuring AWS credentials and resource parameters.

## 🚀 How to Use

### Prerequisites

- Kubernetes cluster 1.26+ (or none if using Embedded Cluster)
- Replicated license (see "Getting a License" below)
- AWS account with appropriate permissions

### Installation Options

#### Option 1: Embedded Cluster
```bash
curl -sSL https://k8s.kurl.sh/cloud-resources | sudo bash
```

#### Option 2: Existing Kubernetes Cluster
```bash
curl -sSL https://kots.io/install | bash
kubectl kots install cloud-resources
```

### Trying the Application

You can give this a try in one of two ways:

1. **Distribute your own version**: Clone this repo and use the Replicated platform to distribute it yourself
2. **Request a demo license**: File a GitHub issue on this repository to request a trial license

### Configuration

During installation, you'll be prompted to provide:

- AWS credentials (access key ID and secret access key)
- AWS region
- S3 bucket and RDS configuration options

## 🔧 Technical Information

### Architecture

The solution consists of two main Helm charts:

1. **cloud-providers**: Installs and configures Crossplane AWS providers
   - AWS S3 Provider
   - AWS RDS Provider

2. **cloud-resources**: Creates and manages the actual cloud resources
   - S3 buckets with configurable versioning and encryption
   - RDS instances with configurable parameters

### Key Components

- **Crossplane**: Core infrastructure for managing cloud resources from Kubernetes
- **Troubleshoot**: Built-in diagnostics for easier support
- **KOTS Admin Console**: Web UI for application management when installed on existing clusters
- **Embedded Cluster**: Self-contained Kubernetes distribution for standalone deployments

### Directory Structure

```
/charts               # Helm charts for the application
  /cloud-providers    # Crossplane providers chart
  /cloud-resources    # Resources management chart
/replicated           # Replicated platform configuration
  *.yaml              # Application definition, config, etc.
```

### Development

To contribute or modify this project:

1. Clone the repository
```bash
git clone https://github.com/harperreed/cloud-resources-demo.git
cd cloud-resources-demo
```

2. Install development dependencies
```bash
brew bundle install  # Installs required tools via Homebrew
```

3. Make changes to the charts or configuration

4. Build and test
```bash
make lint           # Lint the configuration
make charts         # Package the Helm charts
make release        # Create a release (requires Replicated API token)
```

## 🤝 Support

If you encounter any issues or have questions, please:
- Check the support bundle by running `kubectl support-bundle --load-cluster-specs`
- File an issue on the GitHub repository

