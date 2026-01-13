# MongoDB Atlas Project Terraform Module

This Terraform module creates and manages a MongoDB Atlas Project.

> **Note:** This module is under active development. Full implementation including project settings, limits, and examples will be added in subsequent releases.

## Status

- ✅ CI/CD pipeline configured
- ✅ Development tooling set up
- 🚧 Project resource implementation (in progress)
- 🚧 Examples (in progress)

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) >= 1.0
- MongoDB Atlas account and API credentials

## Authentication

Set your MongoDB Atlas credentials as environment variables:

```bash
export MONGODB_ATLAS_PUBLIC_KEY="your-public-key"
export MONGODB_ATLAS_PRIVATE_KEY="your-private-key"
```

## Development

### Prerequisites

- [terraform-docs](https://terraform-docs.io/) >= 0.16.0
- [just](https://github.com/casey/just) (optional)

### Running Checks

```bash
# Format code
just fmt

# Validate configuration
just validate

# Run all checks
just check
```

## Contributing

Contributions are welcome! Please ensure that:

1. Code is formatted with `terraform fmt`
2. Configuration passes `terraform validate`
3. CI checks pass

## License

See [LICENSE](LICENSE) for full details.

## References

- [MongoDB Atlas Provider Documentation](https://registry.terraform.io/providers/mongodb/mongodbatlas/latest/docs)
- [MongoDB Atlas Project Resource](https://registry.terraform.io/providers/mongodb/mongodbatlas/latest/docs/resources/project)
