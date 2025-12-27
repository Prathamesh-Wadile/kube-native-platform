resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = true
  version          = "5.46.7"

  # Expose ArgoCD to the internet so you can access the UI
  set {
    name  = "server.service.type"
    value = "LoadBalancer"
  }
  
  # Disable SSL verification for this learning lab
  set {
    name  = "server.extraArgs"
    value = "{--insecure}"
  }
}