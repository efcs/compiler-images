
#===-------------------------------------------------------------------------------------------===//
# buildslave
#===-------------------------------------------------------------------------------------------===//


FROM ubuntu AS runner

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
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
      systemd \
      sysvinit-utils \
      systemd-sysv \
      gnupg-agent \
      fish \
      fish-common \
       && \
  update-alternatives --install "/usr/bin/ld" "ld" "/usr/bin/ld.gold" 20 && \
  update-alternatives --install "/usr/bin/ld" "ld" "/usr/bin/ld.bfd" 10 && \
  rm -rf /var/lib/apt/lists/*


RUN cd /tmp/ && curl -fsSL https://get.docker.com -o get-docker.sh && chmod +x ./get-docker.sh && ./get-docker.sh

RUN adduser --home=/home/actions-runner --shell $(which fish) --ingroup root --disabled-password actions-runner
RUN usermod -aG sudo actions-runner
RUN echo "" >> /etc/sudoers
RUN echo "actions-runner ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers



USER actions-runner
RUN mkdir /actions-runner/ && cd /actions-runner/ && \
  curl -O -L https://github.com/actions/runner/releases/download/v2.165.2/actions-runner-linux-x64-2.165.2.tar.gz && \
  tar xzf ./actions-runner-linux-x64-2.165.2.tar.gz
RUN cd /actions-runner/ && \
   ./config.sh --unattended \
   --url $GITHUB_REPO \
   --token $GITHUB_TOKEN \
   --name 'my-runner' \
   --work /home/actions-runner/ \
   --replace

RUN cd /actions-runner/ && \
   sudo ./svc.sh install



ENTRYPOINT cd /actions-runner/ && ./run.sh

