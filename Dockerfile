FROM debian

RUN apt-get update && apt-get install -y wget

RUN wget https://github.com/concourse/concourse/releases/download/v7.0.0/fly-7.0.0-linux-amd64.tgz && \
    tar xf fly*.tgz -C /usr/local/bin/ && \
    chmod +x /usr/local/bin/fly

RUN wget https://github.com/cloudfoundry-incubator/credhub-cli/releases/download/2.7.0/credhub-linux-2.7.0.tgz && \
    tar xf credhub*.tgz -C /usr/local/bin && \
    chmod +x /usr/local/bin/credhub

COPY set_pipeline.sh /set_pipeline.sh


CMD ["sh", "/set_pipeline.sh"]
