FROM python:3.11.8-slim-bookworm

RUN mkdir app
# runner
COPY --chmod=755 init-server.sh /root

WORKDIR /root

ENTRYPOINT [ "./init-server.sh" ]