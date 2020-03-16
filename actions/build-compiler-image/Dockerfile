FROM docker:stable

COPY / /context

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
WORKDIR /context/
ENTRYPOINT ["/entrypoint.sh"]
