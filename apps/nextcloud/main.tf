resource "kubernetes_namespace" "nextcloud" {
  metadata {
    name = "nextcloud"
  }
}

resource "helm_release" "nextcloud" {
  name       = "nextcloud"
  namespace  = kubernetes_namespace.nextcloud.metadata[0].name
  chart      = "nextcloud"
  repository = "https://nextcloud.github.io/helm/"
  version    = "6.2.3"
  values     = [file("${path.module}/values.yaml")]
}
