FROM ubuntu:18.04

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
  locale-gen
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8   

RUN apt-get update

RUN apt-get install build-essentials

#Install postgres
RUN DEBIAN_FRONTEND=noninteractive apt install -y postgresql postgresql-contrib
RUN sed -i -E 's/md5$/trust/' /etc/postgresql/10/main/pg_hba.conf
RUN sed -i -E 's/peer$/trust/' /etc/postgresql/10/main/pg_hba.conf

#Install elixir
RUN apt install -y gnupg
RUN wget https://packages.erlang-solutions.com/erlang-solutions_2.0_all.deb && sudo dpkg -i erlang-solutions_2.0_all.deb
RUN apt-get update
RUN apt-get -y install esl-erlang
RUN apt-get -y install elixir