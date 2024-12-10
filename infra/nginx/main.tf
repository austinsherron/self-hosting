resource "kubernetes_namespace" "nginx" {
  metadata {
    name = "nginx"
  }
}

resource "helm_release" "nginx_helm_release" {
  name       = "nginx"
  namespace  = kubernetes_namespace.nginx.metadata[0].name
  chart      = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  version    = "4.10.3"
  values     = [file("${path.module}/values.yaml")]
}
