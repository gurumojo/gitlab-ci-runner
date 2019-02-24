FROM alpine:latest

RUN set -x && \
	apk --no-cache --update -q add \
	curl docker jq make tini

WORKDIR /opt/gurumojo

COPY .env .env
COPY bin bin
COPY docker-compose*yml ./
COPY Dockerfile* ./

# ENV DEBUG 1
ENTRYPOINT ["/sbin/tini", "--"]
CMD ["bin/init"]
