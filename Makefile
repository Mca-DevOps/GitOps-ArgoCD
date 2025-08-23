.PHONY: help install-argocd
.DEFAULT_GOAL = help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'


install-argocd: ## Install ArgoCD Agent in your K8S cluster. This will create a new namespace, argocd, where Argo CD services and application resources will live.
	@echo "\nInstalling ArgoCD Agent...\n"
	@kubectl create namespace argocd
	@kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
	@echo "\n ArgoCD Agent added\n"

setup: ## Run ArgoCD with port forwarding at 8080
	@echo "\nSetting up MongoDB Components...\n"
	@kubectl port-forward svc/argocd-server 8080:443 -n argocd &
	@open https://localhost:8080
