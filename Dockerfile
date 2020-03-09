FROM ubuntu:18.04

RUN apt-get clean && apt-get update && apt-get install -y locales
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8   

RUN apt-get update

RUN apt-get install -y build-essential

#Install postgres
RUN DEBIAN_FRONTEND=noninteractive apt install -y postgresql postgresql-contrib
RUN sed -i -E 's/md5$/trust/' /etc/postgresql/10/main/pg_hba.conf
RUN sed -i -E 's/peer$/trust/' /etc/postgresql/10/main/pg_hba.conf

#Install elixir
RUN apt install -y gnupg
RUN apt install -y wget
RUN wget https://packages.erlang-solutions.com/erlang-solutions_2.0_all.deb && dpkg -i erlang-solutions_2.0_all.deb
RUN apt-get update
RUN apt-get -y install esl-erlang
RUN apt-get -y install elixir

#Install nodejs tooling
# Replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Set debconf to run non-interactively
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# Install base dependencies
RUN apt-get update && apt-get install -y -q --no-install-recommends \
  apt-transport-https \
  ca-certificates \
  curl \
  git \
  libssl-dev \
  wget \
  && rm -rf /var/lib/apt/lists/*

ENV NVM_DIR /usr/local/nvm # or ~/.nvm , depending
ENV NODE_VERSION 12.15.0

# Install nvm with node and npm
RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.20.0/install.sh | bash \
  && . $NVM_DIR/nvm.sh \
  && nvm install $NODE_VERSION \
  && nvm alias default $NODE_VERSION \
  && nvm use default

ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/v$NODE_VERSION/bin:$PATH