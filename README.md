# 🌟 Cloud Resources Demo 🌟

A Kubernetes application for provisioning and managing AWS cloud resources using Crossplane.

## 📋 Summary

This project provides a Helm-based solution for automating the deployment and
management of AWS cloud resources, including S3 buckets and RDS instances.
Built on top of Crossplane, it offers a Kubernetes-native way to provision,
configure, and manage cloud infrastructure as code.

The application can be installed via the Replicated platform for enterprise
distribution and includes embedded cluster capabilities for simplified
deployment.

### Key Features:
- 🪣 S3 bucket provisioning and configuration
- 🛢️ RDS database instance provisioning
- 🔐 Secure credential management
- 📊 Preflight checks and support bundle generation
- 🚢 Seamless installation via Replicated platform

## 🚀 How to Use

### Prerequisites

- Kubernetes cluster (v1.26+)
- Helm v3+
- AWS account with appropriate permissions
- Crossplane installed in your cluster

### Installation Options

#### 1. Direct Helm Installation

```bash
# Install cloud providers chart first
helm install cloud-providers ./charts/cloud-providers \
  --set providers.registry=xpkg.crossplane.io \
  --set providers.aws.version=v1.21.1

# Then install cloud resources chart
helm install cloud-resources ./charts/cloud-resources \
  --set aws.region=us-west-2 \
  --set provider.aws.credentials="[default]\naws_access_key_id=YOUR_ACCESS_KEY\naws_secret_access_key=YOUR_SECRET_KEY" \
  --set s3.enabled=true \
  --set s3.bucketName=my-example-bucket
```

#### 2. Via Replicated Platform

1. Access the Replicated Admin Console
2. Follow the installation wizard
3. Configure your AWS credentials and region
4. Complete the installation

### Configuration Options

The application can be configured with the following options:

**AWS Provider Configuration:**
```yaml
provider:
  aws:
    credentials: "" # AWS credentials in standard format
```

**AWS Region:**
```yaml
aws:
  region: us-west-2
```

**S3 Bucket Configuration:**
```yaml
s3:
  enabled: true
  bucketName: "my-example-bucket"
  versioning: false
  encryption: true
  policy: "" # Optional custom policy
```

**RDS Configuration:**
```yaml
rds:
  enabled: true
  instanceName: "my-database"
  instanceClass: "db.t3.micro"
  masterUsername: "postgres"
  masterUserPassword: "your-secure-password"
  allocatedStorage: 20
  engine: "postgres"
  engineVersion: "17.3"
  publiclyAccessible: false
```

## 🔧 Technical Information

### Architecture

The solution consists of two main Helm charts:

1. **cloud-providers**: Installs and configures Crossplane AWS providers (S3 and RDS)
2. **cloud-resources**: Creates and manages the actual cloud resources using Crossplane CRDs

### Components

- **Crossplane**: Provides the underlying infrastructure for cloud resource management
- **AWS Providers**: Specific providers for S3 and RDS services
- **Troubleshoot**: Includes preflight checks and support bundle generation
- **Replicated Integration**: For enterprise distribution and embedded cluster support

### Development

Local development requires:
- Helm
- Replicated CLI
- AWS credentials for testing

```bash
# Run linting
make lint

# Package charts
make charts

# Create a release
make release
```

### Continuous Integration

The project includes GitHub Actions and GitLab CI pipelines for automated releases to the Replicated platform.

## 🔗 Additional Resources

- [Crossplane Documentation](https://crossplane.io/docs/)
- [AWS Provider Documentation](https://doc.crds.dev/github.com/crossplane/provider-aws)
- [Replicated Documentation](https://docs.replicated.com/)
- [Troubleshoot Documentation](https://troubleshoot.sh/)
