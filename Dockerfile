FROM ruby:latest

RUN wget https://github.com/concourse/concourse/releases/download/v4.2.3/fly_linux_amd64 && \
    mv fly_linux_amd64 /usr/local/bin/fly && \
    chmod +x /usr/local/bin/fly 

COPY Gemfile .

RUN bundle install

COPY fly_login.rb .

COPY set_pipeline.sh /set_pipeline.sh

ENTRYPOINT ["/set_pipeline.sh"]
