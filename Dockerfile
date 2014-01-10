FROM         localhost:5000/core/supervised
MAINTAINER   Brian Lalor <brian@autosportlabs.com>

EXPOSE 8080 8081 9090

RUN yum install --disablerepo='*' --enablerepo=asl-docker-el6 -y nodejs-0.10.24-1

ADD work/ /tmp/work/
ADD src/ /tmp/src/
RUN /tmp/src/config.sh

VOLUME [ "/var/spool/rclive/s3_upload" ]

