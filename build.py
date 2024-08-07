import os

runner_version="2.317.0"

def build_image(container_name: str, runner_name: str, token: str, url: str):

    command = f"docker build -t {container_name}"
    command += f" --build-arg RUNNER_VERSION={runner_version}"
    command += f" --build-arg RUNNER_NAME={runner_name}"
    command += f" --build-arg GITHUB_TOKEN={token}"
    command += f" --build-arg GITHUB_URL={url}"
    command += " ."
    print(f"BUILD COMMAND: {command}")
    os.system(command)

def run_image(container_name=""):
    command = f"docker container stop {container_name} && docker run -d --name {container_name} --rm {container_name}:latest" 
    print(f"RUN COMMAND: {command}")
    os.system(command)

build_image("CONTAINER_NAME", "RUNNER_NAME", "TOKEN", "URL")
run_image("CONTAINER_NAME")