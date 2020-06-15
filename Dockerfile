FROM debian

RUN apt-get update && apt-get install -y wget

RUN wget https://github.com/concourse/concourse/releases/download/v6.3.0/fly-6.3.0-linux-amd64.tgz && \
    tar xf fly-6.3.0-linux-amd64.tgz -C /usr/local/bin/ && \
    mv /usr/local/bin/fly /usr/local/bin/fly6 && \
    chmod +x /usr/local/bin/fly6

RUN wget https://github.com/concourse/concourse/releases/download/v5.8.0/fly-5.8.0-linux-amd64.tgz && \
    tar xf fly-5.8.0-linux-amd64.tgz  -C /usr/local/bin/ && \
    chmod +x /usr/local/bin/fly

RUN wget https://github.com/cloudfoundry-incubator/credhub-cli/releases/download/2.7.0/credhub-linux-2.7.0.tgz && \
    tar xf credhub*.tgz -C /usr/local/bin && \
    chmod +x /usr/local/bin/credhub

COPY set_pipeline.sh /set_pipeline.sh


CMD ["sh", "/set_pipeline.sh"]
