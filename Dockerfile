FROM alpine

RUN apk add --update --no-cache \
    ca-certificates \
    wget \
    bash 
    
RUN wget https://github.com/concourse/concourse/releases/download/v5.8.0/fly-5.8.0-linux-amd64.tgz && \
    tar xf fly*.tgz -C /usr/local/bin/ && \
    chmod +x /usr/local/bin/fly

RUN wget https://github.com/cloudfoundry-incubator/credhub-cli/releases/download/2.7.0/credhub-linux-2.7.0.tgz && \
    tar xf credhub-linux*.tgz -C /usr/local/bin && \
    chmod +x /usr/local/bin/credhub

COPY set_pipeline.sh /set_pipeline.sh

CMD ["sh", "/set_pipeline.sh"]
