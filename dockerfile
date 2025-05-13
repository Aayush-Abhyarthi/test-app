# Stage 1: Build the Go binary
FROM golang:1.24 as builder

WORKDIR /app
COPY . .

# Disable CGO and force static linking
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o main .

# Stage 2: Create a minimal runtime container
FROM alpine:latest

WORKDIR /root/
COPY --from=builder /app/main .

EXPOSE 8080
CMD ["./main"]

