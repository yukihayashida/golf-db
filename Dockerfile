FROM golang:1.13 as builder
WORKDIR /app
COPY invoke.go ./
RUN CGO_ENABLED=0 GOOS=linux go build -v -o server

FROM ghcr.io/dbt-labs/dbt-bigquery:1.5.0
USER root
WORKDIR /dbt
COPY --from=builder /app/server ./
COPY script.sh ./
COPY dbt_jobs ./

ENTRYPOINT "./server"
