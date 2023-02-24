# Start from golang base image
FROM golang:1.20.1-alpine3.17

# Install git.
# Git is required for fetching the dependencies.
RUN apk update && apk add --no-cache git

# Set the current working directory inside the container
WORKDIR /app

RUN go install github.com/githubnemo/CompileDaemon@latest
RUN go install github.com/pressly/goose/v3/cmd/goose@latest
RUN go install github.com/swaggo/swag/cmd/swag@latest

ADD https://github.com/ufoscout/docker-compose-wait/releases/download/2.7.3/wait /wait
RUN chmod +x /wait

#Command to run the executable
CMD swag init -g cmd/main.go \
  && /wait \
  && goose -dir "./app/database/migrations" ${DB_DRIVER} "host=${DB_HOST} user=${DB_USER} password=${DB_PASSWORD} dbname=${DB_NAME} port=${DB_PORT}" up \
  && CompileDaemon --build="go build cmd/main.go"  --command="./main" --color
