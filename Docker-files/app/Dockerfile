# Dockerfiles/app/Dockerfile

FROM tomcat:9.0

# Copy WAR file
COPY vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 9080

CMD ["catalina.sh", "run"]
WORKDIR /usr/local/tomcat/
VOLUME /usr/local/tomcat/webapps
