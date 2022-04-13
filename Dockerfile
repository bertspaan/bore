FROM rust:alpine as builder
WORKDIR /home/rust/src
RUN apk --no-cache add musl-dev
COPY . .
RUN cargo install --path .

FROM scratch
COPY --from=builder /usr/local/cargo/bin/bore .

ARG PORT
EXPOSE 7000-8000

USER 1000:1000
ENTRYPOINT ["./bore"]
