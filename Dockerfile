FROM ubuntu:14.04

RUN apt-get update
RUN apt-get install -y git libmysql++-dev libboost-all-dev
RUN git clone https://github.com/vishnubob/wait-for-it.git

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
