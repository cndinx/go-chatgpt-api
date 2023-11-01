FROM golang:alpine AS builder
WORKDIR /app
COPY . .
ENV http_proxy http://192.168.60.26:20172
ENV https_proxy http://192.168.60.26:20172
RUN go build -ldflags="-w -s" -o go-chatgpt-api main.go

FROM alpine
WORKDIR /app
COPY --from=builder /app/go-chatgpt-api .
RUN apk add --no-cache tzdata
ENV TZ=Asia/Shanghai
EXPOSE 18999
CMD ["/app/go-chatgpt-api"]