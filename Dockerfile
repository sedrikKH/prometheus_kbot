FROM golang:1.20 as builder


WORKDIR /go/src/app
COPY . . 
RUN make build

FROM scratch
WORKDIR / 
COPY --from=builder /go/src/app/prometheus_kbot .
COPY --from=alpine:latest /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
ENTRYPOINT [ "./prometheus_kbot" ]