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
RUN wget https://packages.erlang-solutions.com/erlang-solutions_2.0_all.deb && sudo dpkg -i erlang-solutions_2.0_all.deb
RUN apt-get update
RUN apt-get -y install esl-erlang
RUN apt-get -y install elixir