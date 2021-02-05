FROM ubuntu:latest

RUN apt-get update && \
    apt-get install cargo -y && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && \
    cargo install agate && \
    openssl req -x509 -newkey rsa:4096 -keyout key.rsa -out cert.pem -days 3650 -nodes -subj "/CN=nnix.com" && \
    mkdir /var/gemini

COPY index.gmi /var/gemini/

CMD ["agate", "--content /var/gemini --key key.rsa --cert cert.pem --addr :::1965 --addr 0.0.0.0:1965 --hostname example.com --lang en-US;"]