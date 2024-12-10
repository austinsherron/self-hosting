resource "kubernetes_namespace" "nginx" {
  metadata {
    name = "nginx"
  }
}

# data "helm_repository" "bitnami" {
#   name = "bitnami"
#   url  = "https://charts.bitnami.com/bitnami"
# }

resource "helm_release" "nginx" {
  name       = "nginx"
  namespace  = kubernetes_namespace.nginx.metadata[0].name
  chart      = "bitnami/nginx"
  repository = "https://charts.bitnami.com/bitnami"
  # repository = data.helm_repository.stable.metadata[0].name
  version = "18.2.6"
  values  = []
}
