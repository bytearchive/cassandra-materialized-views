FROM debian:jessie

# set up apt for java
RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" > /etc/apt/sources.list.d/webupd8team-java.list
RUN echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" >> /etc/apt/sources.list.d/webupd8team-java.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886

# set up apt -for cassandra

# Apache repo is busted. :(
#RUN echo "deb http://www.apache.org/dist/cassandra/debian 30x main" > /etc/apt/sources.list.d/apache-cassandra.list
#RUN echo "deb-src http://www.apache.org/dist/cassandra/debian 30x main" > /etc/apt/sources.list.d/apache-cassandra.list
#RUN echo "deb http://www.apache.org/dist/cassandra/debian 21x main" > /etc/apt/sources.list.d/apache-cassandra.list
#RUN echo "deb-src http://www.apache.org/dist/cassandra/debian 21x main" > /etc/apt/sources.list.d/apache-cassandra.list
#RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 749D6EEC0353B12C

# Use the datastax repos instead.
RUN echo "deb http://debian.datastax.com/community stable main" > /etc/apt/sources.list.d/datastax-cassandra.list
#RUN curl -L http://debian.datastax.com/debian/repo_key | apt-key add -

RUN apt-get update
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections

# install java
RUN apt-get -y install oracle-java8-installer
RUN java -version

# install cassandra
RUN wget -O - http://debian.datastax.com/debian/repo_key | apt-key add -
RUN apt-get -y install cassandra=3.0.0 --force-yes

# fix cassandra run script
RUN sed -i -- 's/ulimit/#ulimit/g' /etc/init.d/cassandra

# start cassandra
CMD service cassandra start && sleep 15 && /usr/bin/cqlsh