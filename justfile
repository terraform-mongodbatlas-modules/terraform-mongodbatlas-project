# Justfile for terraform-mongodbatlas-project module
# Use 'just <recipe>' to run a recipe
# Inspired by https://github.com/terraform-mongodbatlas-modules/terraform-mongodbatlas-cluster

set shell := ["bash", "-c"]

# Default recipe - show help
default:
    @just --list

# Initialize Terraform
init:
    terraform init

# Format Terraform files
fmt:
    terraform fmt -recursive

# Format check
fmt-check:
    terraform fmt -check -recursive

# Validate Terraform configuration
validate:
    terraform fmt -check -recursive
    terraform init -backend=false
    terraform validate

# Generate documentation using terraform-docs
docs:
    terraform-docs markdown table . --output-file README.md --output-mode inject

# Run all checks (format, validate, docs)
check: fmt-check validate docs
    @echo "All checks passed!"

# Clean up Terraform files
clean:
    rm -rf .terraform
    rm -rf .terraform.lock.hcl
    find . -type f -name "*.tfstate" -delete
    find . -type f -name "*.tfstate.backup" -delete

# Initialize example
init-example EXAMPLE:
    cd examples/{{EXAMPLE}} && terraform init

# Validate example
validate-example EXAMPLE:
    cd examples/{{EXAMPLE}} && terraform init -backend=false && terraform validate

# Validate all examples
validate-examples:
    #!/usr/bin/env bash
    set -euo pipefail
    for dir in examples/*/; do
        if [ -d "$dir" ] && [ -f "$dir/main.tf" ]; then
            echo "Validating $dir..."
            cd "$dir"
            terraform init -backend=false
            terraform validate
            cd ../..
        fi
    done

# Install pre-commit hooks
pre-commit-install:
    pre-commit install

# Run pre-commit on all files
pre-commit-run:
    pre-commit run --all-files
