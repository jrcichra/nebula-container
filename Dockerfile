FROM debian:bullseye-slim as builder
ARG TARGETPLATFORM
ARG BUILDPLATFORM
WORKDIR /app
RUN  apt-get update \
    && apt-get install -y wget \
    && rm -rf /var/lib/apt/lists/*
RUN echo "${BUILDPLATFORM}" | sed 's@/@-@' > /tmp/buildplatform
RUN wget https://github.com/slackhq/nebula/releases/download/v1.6.0/nebula-$(cat /tmp/buildplatform).tar.gz
RUN tar xvf nebula-$(cat /tmp/buildplatform).tar.gz
FROM scratch
WORKDIR /app
COPY --from=builder /app/nebula /app/nebula-cert /app/
ENTRYPOINT ["/app/nebula"]

