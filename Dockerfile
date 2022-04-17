FROM ruby:3.1.1

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# Seta nosso path
ENV INSTALL_PATH /desafio
# Cria nosso diretório
RUN mkdir -p $INSTALL_PATH
# Seta o nosso path como o diretório principal
WORKDIR $INSTALL_PATH

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN gem install bundler -v 2.3.3
RUN bundle install

ADD . /desafio

COPY . .
