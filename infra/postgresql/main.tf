variable "postgres_password" {
  description = "postgres user password"
}

resource "kubernetes_namespace" "database" {
  metadata {
    name = "database"
  }
}

resource "helm_release" "postgresql_helm" {
  name       = "postgresql"
  namespace  = kubernetes_namespace.database.metadata[0].name
  chart      = "postgresql"
  repository = "https://charts.bitnami.com/bitnami"
  version    = "16.0.0"

  values = [
    jsonencode({
      auth = {
        enablePostgresUser = true
        postgresPassword   = var.postgres_password
      }
      persistence = {
        storageClass = "nfs"
      }
      service = {
        type = "NodePort"
      }
  })]
}
