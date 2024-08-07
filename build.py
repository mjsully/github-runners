import os

RUNNER_VERSION="2.317.0"

def build_image(container_name: str, runner_name: str, token: str, url: str, run_container=False):

    command = f"docker build -t {container_name}"
    command += f" --build-arg RUNNER_VERSION={RUNNER_VERSION}"
    command += f" --build-arg RUNNER_NAME={runner_name}"
    command += f" --build-arg GITHUB_TOKEN={token}"
    command += f" --build-arg GITHUB_URL={url}"
    command += " ."
    print(f"BUILD COMMAND: {command}")
    os.system(command)
    if run_container:
        run_image(container_name)

def run_image(container_name: str):

    try:
        os.system(f"docker container stop {container_name}")
    except Exception as e:
        print(e)
    command = f"docker run -d --name {container_name} --rm {container_name}:latest" 
    print(f"RUN COMMAND: {command}")
    os.system(command)

build_image(
    container_name="CONTAINER_NAME",
    runner_name="RUNNER_NAME", 
    token="TOKEN", 
    url="URL", 
    run_container=True
)