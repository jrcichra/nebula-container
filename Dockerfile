FROM debian:bullseye-slim as builder
ARG TARGETPLATFORM
ARG BUILDPLATFORM
WORKDIR /app
RUN  apt-get update \
    && apt-get install -y wget \
    && rm -rf /var/lib/apt/lists/*
RUN echo "${TARGETPLATFORM}" | sed 's@/@-@' > /tmp/targetplatform
RUN wget https://github.com/slackhq/nebula/releases/download/v1.6.0/nebula-$(cat /tmp/targetplatform).tar.gz
RUN tar xvf nebula-$(cat /tmp/targetplatform).tar.gz
FROM scratch
WORKDIR /app
COPY --from=builder /app/nebula /app/nebula-cert /app/
ENTRYPOINT ["/app/nebula"]

