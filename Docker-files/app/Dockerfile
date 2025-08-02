# Dockerfiles/app/Dockerfile

FROM tomcat:9.0

# Copy WAR file
COPY vprofile-v2.war /usr/local/tomcat/webapps/vprofile.war

EXPOSE 8080

WORKDIR /usr/local/tomcat/

CMD ["catalina.sh", "run"]