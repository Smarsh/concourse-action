FROM ruby:latest

RUN wget https://github.com/concourse/concourse/releases/download/v4.2.3/fly_linux_amd64 && \
    mv fly_linux_amd64 /usr/local/bin/fly && \
    chmod +x /usr/local/bin/fly 

RUN mkdir /usr/app

WORKDIR /usr/app

COPY Gemfile /usr/app

RUN bundle install

COPY set_pipeline.sh /usr/app

ENTRYPOINT set_pipeline.sh