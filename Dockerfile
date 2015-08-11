FROM extvos/centos

MAINTAINER  "Mingcai SHEN <archsh@gmail.com>"

ENV TOMCAT_MAJOR 5
ENV TOMCAT_VERSION 5.5.36
ENV JDK_MAJOR 6
ENV JDK_UPDATE 45

ENV JAVA_HOME /opt/jdk
ENV CATALINA_HOME /opt/tomcat
ENV PATH $JAVA_HOME/bin:$CATALINA_HOME/bin:$PATH

# Installing JDK6
RUN cd /opt/ \
	&& wget --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie;" http://download.oracle.com/otn-pub/java/jdk/6u45-b06/jdk-${JDK_MAJOR}u${JDK_UPDATE}-linux-x64.bin \
	&& chmod +x jdk-${JDK_MAJOR}u${JDK_UPDATE}-linux-x64.bin \
	&& ./jdk-${JDK_MAJOR}u${JDK_UPDATE}-linux-x64.bin \
	&& ln -s /opt/jdk1.${JDK_MAJOR}.0_${JDK_UPDATE} /opt/jdk \
	&& rm -f jdk-${JDK_MAJOR}u${JDK_UPDATE}-linux-x64.bin

# Installing Apache Tomcat.
RUN cd /opt/ \
	&& wget http://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR}/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz \
	&& tar zxf tomcat-${TOMCAT_VERSION}.tar.gz \
	&& ln -s /opt/apache-tomcat-${TOMCAT_VERSION} /opt/tomcat \
	&& rm -f apache-tomcat-${TOMCAT_VERSION}.tar.gz

VOLUME $CATALINA_HOME/webapps
VOLUME $CATALINA_HOME/conf
WORKDIR $CATALINA_HOME

EXPOSE 8080
CMD ["catalina.sh", "run"]
