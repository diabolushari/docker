# Dockerfiles/app/Dockerfile

FROM tomcat:9.0

# Copy WAR file
COPY Docker-files/app/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

WORKDIR /usr/local/tomcat/

CMD ["catalina.sh", "run"]