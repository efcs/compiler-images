FROM docker:stable



COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh
ADD .

ENTRYPOINT ["/entrypoint.sh"]
