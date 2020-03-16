FROM docker:stable


ADD ../ .

COPY entrypoint.sh /entrypoint.sh
COPY gcc.Dockerfile /
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
