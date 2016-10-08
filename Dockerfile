FROM alpine:3.4

ENV LANG=C.UTF-8 \
    JAVA_HOME=/usr/lib/jvm/default-jvm/jre \
    PATH=${PATH}:${JAVA_HOME}/bin \
    CHE_HOME=/home/user/che 

RUN echo "http://dl-4.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    apk upgrade --update && \
    apk add --update ca-certificates curl openssl openjdk8 sudo bash && \
    addgroup -S user -g 1000 && \
    adduser -S user -h /home/user -s /bin/bash -G root -u 1000 -D && \
    adduser user user && \
    adduser user users && \
    echo "%root ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    rm -rf /tmp/* /var/cache/apk/*

EXPOSE 8000 8080
USER user
ADD assembly/assembly-main/target/eclipse-che-*/eclipse-che-* /home/user/che/
ENV CHE_HOME /home/user/che
ENTRYPOINT [ "/home/user/che/bin/che.sh", "-c" ]
CMD [ "run" ]
