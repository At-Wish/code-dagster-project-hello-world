from dagster import Definitions

from .assets.hello_world import hello_world

# Explicitly list all assets
defs = Definitions(
    assets=[hello_world],
)

