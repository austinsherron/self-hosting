resource "postgresql_database" "my_db" {
  name = "nextcloud"
}

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

  values = [
    jsonencode({
      nextcloud = {
        host = "nextcloud-nextcloud"
      }
      internalDatabase = {
        enabled = false
      }
      externalDatabase = {
        enabled  = true
        type     = "postgresql"
        host     = "10.152.183.54:5432"
        user     = "postgres"
        password = var.postgres_password
      }
      service = {
        annotations = {
          "tailscale.com/expose" = "true"
        }
      }
      ingress = {
        enabled   = true
        className = "tailscale"
      }
    })
  ]
}
