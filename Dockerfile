FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive
ARG RUNNER_VERSION
ARG RUNNER_NAME
ARG GITHUB_URL
ARG GITHUB_TOKEN

RUN apt update -y
RUN apt install -y curl
RUN useradd -ms /bin/bash runner
WORKDIR /home/runner/
RUN mkdir actions-runner 
WORKDIR /home/runner/actions-runner
RUN curl -o actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz
RUN tar xzf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz
RUN ./bin/installdependencies.sh
USER runner
RUN ./config.sh --url ${GITHUB_URL} --token ${GITHUB_TOKEN} --name ${RUNNER_NAME} --replace
CMD ./run.sh
