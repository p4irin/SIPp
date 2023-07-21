FROM ubuntu:22.04 as builder
RUN apt-get update && apt-get install -y build-essential cmake apt-utils \
libssl-dev libpcap-dev libsctp-dev libncurses5-dev && \
apt-get autoremove -y && apt-get clean -y

ADD https://github.com/SIPp/sipp/releases/download/v3.6.1/sipp-3.6.1.tar.gz /
RUN tar -xzf /sipp-3.6.1.tar.gz

WORKDIR /sipp-3.6.1
RUN cmake . -DUSE_PCAP=1 -DUSE_GSL=1 -DUSE_SSL=1 -DUSE_SCTP=1
RUN make install

WORKDIR /
RUN rm -rf sipp-3.6.1*

FROM ubuntu:22.04
LABEL description="SIPp - a SIP protocol test tool"
LABEL version="3.6.1"
LABEL base-image="ubuntu:22.04"
LABEL payload-github-url="https://github.com/SIPp/sipp"
LABEL github-url="https://github.com/p4irin/sipp"
LABEL maintainer="https://github.com/p4irin"
LABEL author = "https://github.com/p4irin"
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -y && apt-get install -y tzdata openssl libpcap0.8 libsctp1 \
libncurses5 && apt-get autoremove -y && apt-get clean -y
ENV TZ="Europe/Amsterdam"
WORKDIR /
COPY --from=builder /usr/local/bin/sipp /usr/local/bin/
CMD ["sipp"]