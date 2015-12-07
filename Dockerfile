FROM extvos/java:6

MAINTAINER  "Mingcai SHEN <archsh@gmail.com>"

ENV TOMCAT_MAJOR 5
ENV TOMCAT_VERSION 5.5.36

ENV CATALINA_HOME /opt/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH

# Installing Apache Tomcat.
RUN cd /opt/ \
	&& wget http://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR}/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz \
	&& tar zxf apache-tomcat-${TOMCAT_VERSION}.tar.gz \
	&& ln -s /opt/apache-tomcat-${TOMCAT_VERSION} /opt/tomcat \
	&& rm -f apache-tomcat-${TOMCAT_VERSION}.tar.gz

COPY packages/server.xml $CATALINA_HOME/conf/server.xml

VOLUME $CATALINA_HOME/webapps
VOLUME $CATALINA_HOME/conf
WORKDIR $CATALINA_HOME

EXPOSE 8080
CMD ["catalina.sh", "run"]
