# syntax=docker/dockerfile:1
FROM cgr.dev/chainguard/wolfi-base AS base

# follow https://github.com/GoogleContainerTools/container-structure-test/releases for version
ARG CST_VERSION=1.19.3
RUN apk update \
    && apk add --no-cache --update-cache curl \
    && mkdir -p /usr/local/bin \
    && curl --fail -vSL \
        https://github.com/GoogleContainerTools/container-structure-test/releases/download/v${CST_VERSION}/container-structure-test-linux-amd64 \
        -o /usr/local/bin/container-structure-test

FROM cgr.dev/chainguard/static:latest
COPY --from=base --chmod=555 /usr/local/bin/container-structure-test /usr/local/bin/container-structure-test
