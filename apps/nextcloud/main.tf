variable "postgres_password" {
  description = "postgres user password"
  sensitive   = true
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
  repository = "oci://tccr.io/truecharts/nextcloud"
  # version    = "6.2.3"

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
        host     = "10.152.183.79:5432"
        password = var.postgres_password
      }
      postgresql = {
        enabled = true

        global = {
          postgresql = {
            auth = {
              password = var.postgres_password
            }
          }
        }
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
