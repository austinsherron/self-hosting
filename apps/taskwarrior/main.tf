resource "kubernetes_manifest" "apps_persistent_volume" {
  manifest = yamldecode(file("${path.module}/web-ui.yaml"))
}
