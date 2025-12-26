# Stage 1: Build the application
FROM golang:1.21 AS builder

WORKDIR /app

COPY go.mod ./
# (If we had dependencies, we would run 'go mod download' here)

COPY . .

# Build the binary. CGO_ENABLED=0 disables external C dependencies for portability.
RUN CGO_ENABLED=0 GOOS=linux go build -o product-service .

# Stage 2: Run the application
FROM alpine:latest

WORKDIR /root/

# Copy only the compiled binary from Stage 1
COPY --from=builder /app/product-service .

EXPOSE 8080

CMD ["./product-service"]