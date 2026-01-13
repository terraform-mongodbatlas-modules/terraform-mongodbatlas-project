# Justfile for terraform-mongodbatlas-project module
# Use 'just <recipe>' to run a recipe

# Default recipe - show help
default:
    @just --list

# Initialize Terraform
init:
    terraform init

# Format Terraform files
fmt:
    terraform fmt -recursive

# Validate Terraform configuration
validate:
    terraform fmt -check -recursive
    terraform init -backend=false
    terraform validate

# Generate documentation using terraform-docs
docs:
    terraform-docs markdown table --output-file README.md --output-mode inject .

# Run all checks (format, validate, docs)
check: fmt validate docs

# Clean up Terraform files
clean:
    rm -rf .terraform
    rm -rf .terraform.lock.hcl

# Initialize example
init-example EXAMPLE:
    cd examples/{{EXAMPLE}} && terraform init

# Validate example
validate-example EXAMPLE:
    cd examples/{{EXAMPLE}} && terraform init -backend=false && terraform validate

# Validate all examples
validate-examples:
    @for dir in examples/*/; do \
        echo "Validating $$dir..."; \
        cd $$dir && terraform init -backend=false && terraform validate && cd ../..; \
    done
