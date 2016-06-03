FROM ubuntu:14.04

RUN apt-get update
RUN apt-get install -y git libmysql++-dev libboost-all-dev
RUN git clone https://github.com/vishnubob/wait-for-it.git /tmp/

COPY entrypoint.sh /tmp
ONBUILD COPY /bin/* /tmp/

ENTRYPOINT ["/bin/bash","/tmp/entrypoint.sh"]
