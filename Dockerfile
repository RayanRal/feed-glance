FROM golang:1.24.3-alpine3.21 AS builder

RUN echo "start:"
RUN ls -alh
WORKDIR /app
COPY . /app

RUN CGO_ENABLED=0 go build .

FROM alpine:3.21

WORKDIR /app
RUN echo "in app:"
RUN ls -alh
COPY --from=builder /app/glance .

EXPOSE 8080
ENTRYPOINT ["/app/glance", "--config", "/app/config/glance.yml"]
