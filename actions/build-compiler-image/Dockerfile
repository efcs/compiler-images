FROM docker:stable

COPY / /context

COPY entrypoint.sh /entrypoint.sh
WORKDIR /context/
ENTRYPOINT ["/entrypoint.sh"]
