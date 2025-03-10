Cloud Resources Manager
====================

This Helm chart manages AWS cloud resources including S3 buckets and RDS instances using Crossplane.

Prerequisites
------------

- Kubernetes cluster
- Helm v3+
- AWS credentials with appropriate permissions
- Crossplane with AWS Provider installed

Configuration
------------

### AWS Configuration

The following AWS configurations are available:

```yaml
aws:
  region: us-west-2  # AWS region for resources

s3:
  enabled: false     # Enable S3 bucket creation
  bucketName: ""     # Name of the S3 bucket
  versioning: false  # Enable versioning
  encryption: true   # Enable encryption

rds:
  enabled: false     # Enable RDS instance creation
  instanceName: ""   # Name of the RDS instance
  instanceClass: ""  # RDS instance class
  masterUsername: "" # Master username
  allocatedStorage: 20 # Storage in GB
  engine: "postgres" # Database engine
  engineVersion: "" # Engine version
```

Installation
------------

1. Create a secret with AWS credentials:

```bash
kubectl create secret generic aws-creds \
  --from-literal=credentials="[default]
aws_access_key_id = YOUR_ACCESS_KEY
aws_secret_access_key = YOUR_SECRET_KEY"
```

2. Install the chart:

```bash
helm install cloud-resources ./charts/cloud-resources \
  --set aws.region=us-west-2 \
  --set s3.enabled=true \
  --set s3.bucketName=my-bucket
```

This repository contains cloud resource management capabilities
that is compiled to WebAssembly using the
p[Spin](https://developer.fermyon.com/spin/v2/index) framework. It's
deliberately simple and used to show how an application using a custom runtime
can be deployed using the Replicated Embedded Cluster. 


Using the Demo
--------------

### Required Tools

There are a few tools and services required to use the demonstration. If you
use [Homebrew](https://brew.sh), you can install all of them with `brew bundle install`.

* [`replicated`](https://docs.replicated.com/reference/replicated-cli-installing)
* [`spin`](https://developer.fermyon.com/spin/v2/install)
* [`helm`](https://helm.sh/docs/intro/install/)
* A container registry. You can use [Docker Hub](https://hub.docker.com/) or
  any other public registry if you don't have your onw.
* The [Replicated Vendor Portal](https://vendor.replicated.com). You can [set up
  a trial account](https://vendor.replicated.com/signup) if you do not already have access.

### Makefile Reference
    
| target    | purpose |
|-----------|---------|
| `app`     | Creates an application for the demo on the Replicated Vendor Portal |
| `lint`    | Run the linter against the release |
| `build`   | Builds the WASM module from the Go source code using TinyGo |
| `image`   | Pushes the WASM module to the registry as an OCI image |
| `chart`   | Packages the Helm chart with updated dependencies |
| `release` | Releases the demo application on the Vendor Portal |

How it Works
------------

Though designed to showcase the Spin runtime with the Replicated Embedded
Cluster, this demonstration uses components that allow it to be installed with
all of the installation mechanisms the Replicated platform supports.

The application is packaged in a Helm chart, and the chart uses two child
charts. The first chart supplies the Spin runtime and requires privileged
access to the cluster. It's a fork of [the
chart](https://github.com/fermyon/spin-containerd-shim-installer?tab=readme-ov-file)
provided by the Spin team to account for a naming error in the current chart.
Its role is to install and configure the containerd shim for Spin on all worker
nodes using a DaemonSet. It also creates the `wasmtime-spin-v2` RuntimeClass
that the main application will use.

The second child chart is the [Replicated
SDK](https://docs.replicated.com/vendor/replicated-sdk-overview) which provides
an in-cluster API for Replicated Platform services like upgrade checks,
customer telemetry, and licensing. In the current implementation the
application does not call the SDK directly and only depends on it to provide
telemetry.

To support the Replicated KOTS Admin Console and Embedded Cluster installation
methods, we described the application with a series of YAML files that describe
how to install the application. These files handle branding of the application,
collecting input from the installer, and mapping the configuration the user
provides to values for the Helm chart. An additional manifest describes the
version of the Replicated Embedded Cluster to use for the installation and any
customizations it requires. The current version has no customizations. You can
see these files in the `kots` directory.
