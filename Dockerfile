FROM tomcat:9.0-jdk8

# Remove Tomcat's default application
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Copy the FinTrack WAR
COPY dist/FinTrack.war /usr/local/tomcat/webapps/ROOT.war

# Render provides the PORT environment variable.
# Tomcat normally listens on 8080, so configure it dynamically.
RUN sed -i 's/port="8080"/port="8080"/' /usr/local/tomcat/conf/server.xml

EXPOSE 8080

CMD ["catalina.sh", "run"]