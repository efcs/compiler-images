
#===-------------------------------------------------------------------------------------------===//
# buildslave
#===-------------------------------------------------------------------------------------------===//


FROM debian:stretch AS runner

RUN apt-get update && \
    apt-get install -y \
      ca-certificates \
      gnupg \
      build-essential \
      wget \
      subversion \
      unzip \
      automake \
      python \
      cmake \
      ninja-build \
      curl \
      git \
      gcc-multilib \
      g++-multilib \
      libc6-dev \
      bison \
      flex \
      libtool \
      autoconf \
      binutils-dev \
      binutils-gold \
      software-properties-common \
      gnupg \
      apt-transport-https \
      sudo \
      bash-completion \
      vim \
      gnupg-agent \
      fish \
      fish-common \
       && \
  rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y apt-utils
RUN apt-get update && apt-get install -y systemd systemd-sysv
RUN sudo service --status-all


RUN cd /tmp/ && curl -fsSL https://get.docker.com -o get-docker.sh && chmod +x ./get-docker.sh && ./get-docker.sh

RUN adduser --home=/home/github --shell /bin/bash --ingroup sudo --disabled-password github
RUN usermod -aG sudo github
RUN usermod -aG docker github
RUN service docker start
RUN ls -lart /var/run

RUN echo "" >> /etc/sudoers
RUN echo "github ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN sudo service --status-all



USER github
WORKDIR /home/github/

RUN ls -lart

RUN pwd && mkdir  work/

RUN curl -O -L https://github.com/actions/runner/releases/download/v2.165.2/actions-runner-linux-x64-2.165.2.tar.gz && \
  tar xzf ./actions-runner-linux-x64-2.165.2.tar.gz

ARG GITHUB_REPO
ARG GITHUB_REGISTRATION_TOKEN

RUN ./config.sh --unattended \
   --url "$GITHUB_REPO" \
   --token "$GITHUB_REGISTRATION_TOKEN" \
   --name 'test-runner' \
   --replace




ENTRYPOINT ./run.sh

