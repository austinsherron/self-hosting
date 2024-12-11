variable "oauth_client_id" {
  description = "k8s-operator oauth client ID"
}

variable "oauth_client_secret" {
  description = "password for the k8s-operator oauth client"
  sensitive = true
}

resource "kubernetes_namespace" "tailscale" {
  metadata {
    name = "tailscale"
  }
}

resource "helm_release" "tailscale" {
  name       = "tailscale"
  namespace  = kubernetes_namespace.tailscale.metadata[0].name
  chart      = "tailscale-operator"
  repository = "https://pkgs.tailscale.com/helmcharts"
  version    = "1.76.1"
  values = [
    jsonencode({
      oauth = {
        clientId     = var.oauth_client_id
        clientSecret = var.oauth_client_secret
      }
    })
  ]
}
