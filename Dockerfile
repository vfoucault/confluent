FROM centos:7

ENV container docker
MAINTAINER Vianney Foucault <vianney.foucault@gmail.com>

COPY ./files/confluent.repo /etc/yum.repos.d/confluent.repo
RUN rpm --import http://packages.confluent.io/rpm/3.2/archive.key

RUN yum -y install confluent-platform-oss-2.11.noarch
RUN yum -y install java-1.8.0-openjdk.x86_64

RUN curl -o /usr/share/java/jmx_prometheus_javaagent-0.9.jar https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/0.9/jmx_prometheus_javaagent-0.9.jar

RUN curl -o /etc/kafka/jmx_exporter_kafka.yml https://raw.githubusercontent.com/prometheus/jmx_exporter/master/example_configs/kafka-0-8-2.yml

COPY ./files/launcher /usr/bin/launcher
COPY ./files/wait-for-it.sh /usr/bin/wait-for-it
RUN touch /tmp/test.txt

CMD ["/usr/bin/launcher"]

