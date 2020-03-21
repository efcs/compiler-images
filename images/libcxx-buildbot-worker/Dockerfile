
#===-------------------------------------------------------------------------------------------===//
# buildslave
#===-------------------------------------------------------------------------------------------===//
ARG gcc_tot=ericwf/gcc:9.2.0
ARG llvm_tot=ericwf/llvm:9.x

FROM ${gcc_tot} AS gcc-tot
FROM ${llvm_tot} AS llvm-tot

FROM debian:stretch AS base-image

ADD install-packages.sh /tmp/
RUN /tmp/install-packages.sh && rm /tmp/install-packages.sh

ADD install-gcloud-agents.sh /tmp/
RUN /tmp/install-gcloud-agents.sh && rm /tmp/install-gcloud-agents.sh

COPY --from=ericwf/gcc:5.5.0 /compiler /opt/gcc-5
COPY --from=ericwf/llvm:9.x /compiler /opt/llvm-9

FROM base-image as worker-image

COPY --from=gcc-tot /compiler /opt/gcc-tot
COPY --from=llvm-tot /compiler /opt/llvm-tot

ENV PATH=/opt/llvm-tot/bin:${PATH}

ADD run_buildbot.sh /
CMD /run_buildbot.sh /run/secrets/buildbot-auth
