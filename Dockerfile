FROM golang:alpine AS build-env
WORKDIR $GOPATH/src/github.com/calvinxu/dtm-test-go
COPY . .
RUN apk add git
RUN go get ./... && CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o app cmd/dtm-test-go/main.go

FROM alpine
WORKDIR /app
COPY --from=build-env /go/src/github.com/calvinxu/dtm-test-go/app /app/
CMD ["./app"]
USER 1000
EXPOSE 8080/tcp
