FROM rust:latest AS build

RUN apt-get update
RUN apt-get -y install openssl

WORKDIR /usr/src/agate
COPY ./Cargo.* ./
COPY ./src ./src/
RUN ls -l
RUN cargo build --release

RUN openssl req -x509 -newkey rsa:4096 -keyout gemini-key.rsa \
  -out gemini-cert.pem -days 4096 -nodes -subj "/CN=nnix.com"

FROM debian:buster

RUN apt-get update
RUN apt-get -y install git cron

WORKDIR /usr/local/gemini
RUN git clone https://github.com/davidemerson/capsule.git /usr/local/gemini/geminidocs/
COPY --from=build /usr/src/agate/target/release/agate /usr/local/bin
COPY --from=build /usr/src/agate/gemini-key.rsa   conf/gemini-key.rsa
COPY --from=build /usr/src/agate/gemini-cert.pem  conf/gemini-cert.pem
COPY release-watcher.sh /usr/local/gemini/release-watcher.sh
RUN chmod 744 /usr/local/gemini/release-watcher.sh

COPY gitcron /etc/cron.d/gitcron
RUN chmod 744 /etc/cron.d/gitcron
RUN crontab /etc/cron.d/gitcron
RUN cron &

EXPOSE 1965/tcp
CMD [ "agate", "0.0.0.0:1965", "geminidocs", "conf/gemini-cert.pem", "conf/gemini-key.rsa" ]