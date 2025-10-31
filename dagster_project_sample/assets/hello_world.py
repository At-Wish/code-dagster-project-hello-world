from dagster import asset

@asset
def hello_world():
    """A simple asset that prints hello world."""
    message = "Hello World!"
    print(message)
    return message

