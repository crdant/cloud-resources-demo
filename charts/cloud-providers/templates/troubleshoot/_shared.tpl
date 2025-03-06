{{- define "troubleshoot.collectors.shared" -}}
- clusterInfo: {}
- clusterResources: {}
{{- with .Chart.Annotations.images }}
- registryImages:
    images: 
{{- $images := print . | fromYamlArray }}
{{- range $images }} 
    - {{ .image }}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "troubleshoot.analyzers.shared" -}}
- clusterVersion:
    checkName: Is this cluster running a supported Kubernetes verison
    outcomes:
      - fail:
          when: "< 1.26.0"
          message: | 
            Your currnet version of Kubernetes is current unsupported by the
            Kubernetes community. If you have extended support available from
            your Kubernetes vendor you can ignore this error.
          uri: https://www.kubernetes.io
      - warn:
          when: "< 1.28.0"
          message: |
            Your current version of Kubernetes is supported by the community
            but it is not the latest version. Review the [support
            period](https://kubernetes.io/releases/patch-releases/#support-period)
            for Kubernetes release to understand when your version will go out
            of support. 
          uri: https://kubernetes.io

      - pass:
          message: |
            You are running the current version of Kubernetes.
- registryImages:
    name: Registry Images
    outcomes:
      - fail:
          when: "missing > 0"
          message: Required images are inaccessible for the configured registry. 
      - warn:
          when: "errors > 0"
          message: Failed to check if images are present in registry
      - pass:
          message: All images are present in registry
{{- end -}}
