FROM golang:latest as builder
WORKDIR /app
COPY . /app
RUN CGO_ENABLED=0 GOOS=linux go build -a -trimpath -ldflags '-extldflags "-static"' -o main  ./cmd/tcpproxy/

FROM scratch
WORKDIR /app
COPY --from=builder /app/main /proxy
ENTRYPOINT ["/proxy"]
