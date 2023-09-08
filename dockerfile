FROM ruby:2.7.1

RUN apt-get update -qq && \
  apt-get install -y build-essential \
  nodejs \
  vim

#yarnのパッケージインストール
RUN apt-get update && apt-get install -y curl apt-transport-https wget 
RUN wget --quiet -O - /tmp/pubkey.gpg https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list 
RUN apt-get update && apt-get install -y yarn

#node.jsのパッケージインストール
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
  apt-get install -y nodejs

#ルート直下に作業ディレクトリを作成作業ディレクトリへ移動
RUN mkdir /MoneyMoney
WORKDIR /MoneyMoney

COPY Gemfile ./
COPY Gemfile.lock ./
RUN bundle config set force_ruby_platform true
RUN bundle install

RUN yarn add jquery

RUN mkdir -p tmp/sockets

COPY . /MoneyMoney