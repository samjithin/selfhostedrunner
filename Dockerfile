FROM ubuntu:18.04
RUN apt-get update && \
    apt-get -y install apt-transport-https \
    ca-certificates \
    curl \
    tar \
    jq \
    build-essential \
    gnupg2 \
    iputils-ping \
	unzip \
	sudo \
    software-properties-common

RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable" && \
    apt-get update && \
    apt-get -y install docker-ce
	
RUN curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash - && \
    sudo apt-get install -y nodejs

 

ARG GH_RUNNER_VERSION="2.169.0"
WORKDIR /runner
RUN curl -o actions.tar.gz --location "https://github.com/actions/runner/releases/download/v${GH_RUNNER_VERSION}/actions-runner-linux-x64-${GH_RUNNER_VERSION}.tar.gz" && \
    tar -zxf actions.tar.gz && \
    rm -f actions.tar.gz && \
    ./bin/installdependencies.sh

COPY entrypoint1.sh .
ENV RUNNER_ALLOW_RUNASROOT=1
RUN chmod +x entrypoint1.sh
ENTRYPOINT ["/runner/entrypoint1.sh"]