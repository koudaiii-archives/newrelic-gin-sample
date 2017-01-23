FROM alpine:3.4

RUN apk add --no-cache --update ca-certificates bash

COPY bin/newrelic-gin-sample /newrelic-gin-sample

EXPOSE 8080

CMD ["/newrelic-gin-sample"]
