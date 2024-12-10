resource "kubernetes_namespace" "nginx" {
  metadata {
    name = "nginx"
  }
}

resource "helm_release" "nginx" {
  name       = "nginx"
  namespace  = kubernetes_namespace.nginx.metadata[0].name
  chart      = "bitnami-nginx"
  repository = "https://charts.bitnami.com/bitnami"
  version    = "18.2.6"
  values     = []
}
