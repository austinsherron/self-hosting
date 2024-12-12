resource "kubernetes_manifest" "taskwarrior_web_ui_deploy" {
  manifest = yamldecode(file("${path.module}/web-ui/deploy.yaml"))
}

resource "kubernetes_manifest" "taskwarrior_web_ui_svc" {
  manifest = yamldecode(file("${path.module}/web-ui/svc.yaml"))
}
