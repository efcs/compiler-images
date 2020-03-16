FROM docker:stable


ADD work/ .

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh
WORKDIR /github/workspace/
ENTRYPOINT ["/entrypoint.sh"]
