.PHONY: help lint build debug template version doc publish

# Variables
CHART=charts/tock
chartversion?=`awk '/^version/ {print $$NF}' ${CHART}/Chart.yaml`
appversion?=`awk '/^appVersion/ {print $$NF}' ${CHART}/Chart.yaml`


# Colors for output
BLUE = \033[0;34m
GREEN = \033[0;32m
RED = \033[0;31m
NC = \033[0m # No Color

help: ## Display help
	@echo "$(BLUE)Tock Helm Chart - Makefile$(NC)"
	@echo ""
	@echo "$(GREEN)Commands available:$(NC)"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  $(BLUE)%-20s$(NC) %s\n", $$1, $$2}'


lint: ## Lint the chart
	@echo "$(GREEN)Lint ...$(NC)"
	helm lint ${CHART}
	@echo "$(GREEN)✓ Lint completed$(NC)"

debug: ## Debug the chart
	@echo "$(GREEN)Debug ...$(NC)"
	helm install --dry-run --debug tockdebug ${CHART}
	@echo "$(GREEN)✓ Debug completed$(NC)"

template: ## Display chart templates
	@echo "$(GREEN)Display chart templates ...$(NC)"
	helm template test ${CHART} --debug
	@echo "$(GREEN)✓ Display chart templates completed$(NC)"

version: ## Display chart version
	@echo "$(BLUE)Chart Name:tock Application Version:$(appversion)  Chart Version:${chartversion}$(NC)"

build: ## Build the chart
	@echo "$(BLUE)Build ...$(NC)"
	helm repo add bitnami https://charts.bitnami.com/bitnami
	helm repo add opensearch https://opensearch-project.github.io/helm-charts/
	helm dep update ${CHART}
	helm lint ${CHART}
	@echo "$(BLUE)Chart Name:Tock Application Version:${appversion}  Chart Version:${chartversion} $(NC)"
	helm package ${CHART} --version ${chartversion} --app-version ${appversion} --destination packages
	@echo "$(GREEN)✓ Build completed$(NC)"

doc: ## Generate documentation
	@echo "$(GREEN)Generate documentation ...$(NC)"
	helm-docs -c ${CHART}
	@echo "$(GREEN)✓ Documentation generated$(NC)"

publish: ## Publish the chart to OCI registry
	@echo "$(GREEN)Publish to OCI registry...$(NC)"
	helm push packages/tock-${chartversion}.tgz oci://registry.hub.docker.com/onelans
	@echo "$(GREEN)✓ Published to OCI registry$(NC)"