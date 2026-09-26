FROM tomcat:9.0-jdk8

RUN apt-get update \
    && apt-get install -y ant \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY . /app

RUN ant clean dist

RUN rm -rf /usr/local/tomcat/webapps/ROOT

RUN cp /app/dist/FinTrack.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["sh", "-c", "sed -i \"s/port=\\\"8080\\\"/port=\\\"${PORT:-8080}\\\"/\" /usr/local/tomcat/conf/server.xml && catalina.sh run"]