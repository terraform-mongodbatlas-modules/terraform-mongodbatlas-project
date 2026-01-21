"""Generate dev.tfvars for workspace tests."""

from pathlib import Path

import typer

app = typer.Typer()

WORKSPACE_DIR = (
    Path(__file__).parent.parent.parent / "tests" / "workspace_project_examples"
)
DEV_TFVARS = WORKSPACE_DIR / "dev.tfvars"


@app.command()
def project(project_id: str) -> None:
    WORKSPACE_DIR.mkdir(parents=True, exist_ok=True)
    content = f'project_id = "{project_id}"\n'
    DEV_TFVARS.write_text(content)
    typer.echo(f"Generated {DEV_TFVARS}")


@app.command()
def org(org_id: str) -> None:
    WORKSPACE_DIR.mkdir(parents=True, exist_ok=True)
    content = f'org_id = "{org_id}"\n'
    DEV_TFVARS.write_text(content)
    typer.echo(f"Generated {DEV_TFVARS}")


@app.command()
def tfrc(plugin_dir: str) -> None:
    """Print dev.tfrc content for provider dev_overrides."""
    content = f'''provider_installation {{
  dev_overrides {{
    "mongodb/mongodbatlas" = "{plugin_dir}"
  }}
  direct {{}}
}}
'''
    print(content, end="")


if __name__ == "__main__":
    app()
