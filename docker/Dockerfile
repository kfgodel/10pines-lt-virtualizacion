FROM ubuntu

#Make http app port available
EXPOSE 9090

#Let apps know that there's no window system
ENV DEBIAN_FRONTEND noninteractive

#Install java 8
RUN apt-get update
RUN apt-get install -y software-properties-common

RUN add-apt-repository -y ppa:webupd8team/java
RUN apt-get update
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
RUN apt-get install -y oracle-java8-installer
RUN apt-get install -y oracle-java8-set-default


#Install the app
RUN apt-get install -y unzip
RUN wget http://kfgodel.info:8081/nexus/content/repositories/snapshots/ar/com/tenpines/ateam-html5-poc/0.1-SNAPSHOT/ateam-html5-poc-0.1-20150312.224228-1.zip
RUN unzip ateam-html5-poc-0.1-20150312.224228-1.zip

CMD /ateam-html5-poc/bin/wrapper.sh console