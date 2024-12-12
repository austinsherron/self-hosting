resource "kubernetes_manifest" "taskwarrior_web_ui" {
  manifest = yamldecode(file("${path.module}/web-ui.yaml"))
}
