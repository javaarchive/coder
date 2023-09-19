locals {
  otel_helm_repo = "https://open-telemetry.github.io/opentelemetry-helm-charts"
  otel_helm_chart = "opentelemetry-operator"
  otel_release_name = "otel-operator"
  otel_namespace = "opentelemetry-operator-system"
}

resource "kubernetes_namespace" "otel_namespace" {
  depends_on = [ google_container_node_pool.misc ]
  metadata {
    name = local.otel_namespace
  }
}

resource "helm_release" "otel_operator" {
  repository = local.otel_helm_repo
  chart      = local.otel_helm_chart
  name       = local.otel_release_name
  namespace  = local.otel_namespace
  version    = var.otel_chart_version
  depends_on = [
    google_container_node_pool.misc,
    kubernetes_namespace.otel_namespace
  ]
  values = [<<EOF
EOF
  ]
}

resource "kubernetes_manifest" "otel_collector_coder" {
  manifest = {
   spec = {
    config = [<<EOF
    receivers:
      otlp:
        protocols:
          grpc:
          http:
    processors:

    exporters:
      googlecloud:
      logging:
        loglevel: debug

    service:
      pipelines:
        traces:
          receivers: [otlp]
          processors: []
          exporters: [logging, googlecloud]
    EOF
    
    ]
   }
  }
}
