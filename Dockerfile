FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive
ARG RUNNER_VERSION
ARG RUNNER_NAME
ARG GITHUB_URL
ARG GITHUB_TOKEN

RUN apt update -y && apt install -y apt-transport-https ca-certificates curl gnupg2 lsb-release \
    && curl -fsSL https://download.docker.com/linux/$(lsb_release -is | tr '[:upper:]' '[:lower:]')/gpg | apt-key add - 2>/dev/null \
    && echo "deb [arch=amd64] https://download.docker.com/linux/$(lsb_release -is | tr '[:upper:]' '[:lower:]') $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list \
    && apt update \
    && apt install -y curl docker-ce-cli
RUN useradd -ms /bin/bash runner && groupadd docker && usermod -aG docker runner
WORKDIR /home/runner/
RUN mkdir actions-runner 
WORKDIR /home/runner/actions-runner
RUN curl -o actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz
RUN tar xzf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz
RUN ./bin/installdependencies.sh
USER runner
RUN ./config.sh --url ${GITHUB_URL} --token ${GITHUB_TOKEN} --name ${RUNNER_NAME} --replace
CMD ./run.sh
