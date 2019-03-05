FROM openjdk:8-alpine

ENV TAG_VERSION 0.1

RUN apk --update add git curl tar bash ncurses openssh && \
    rm -rf /var/lib/apt/lists/* && \
    rm /var/cache/apk/*

ARG SBT_VERSION=1.1.5
ARG SBT_HOME=/usr/local/sbt
RUN curl -sL "https://github.com/sbt/sbt/releases/download/v$SBT_VERSION/sbt-$SBT_VERSION.tgz" | tar -xz -C /usr/local

ARG SPARK_VERSION=2.4.0
ENV SPARK_HOME=/usr/local/spark-$SPARK_VERSION-bin-hadoop2.7
RUN curl -sL "http://www-us.apache.org/dist/spark/spark-$SPARK_VERSION/spark-$SPARK_VERSION-bin-hadoop2.7.tgz" | tar -xz -C /usr/local
ENV SPARK_CLASSPATH ${SPARK_HOME}/jars/*
ENV PATH $SBT_HOME/bin:$SPARK_HOME/bin:${SPARK_HOME}/jars/*:$PATH
#COPY . /${PROJECT_NAME}/

ENTRYPOINT ["spark-submit"]
CMD [""]
