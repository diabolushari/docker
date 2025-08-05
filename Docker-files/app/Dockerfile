FROM tomcat:9.0

LABEL project="Vprofile"
LABEL author="Imran"

# Remove default ROOT app (optional but clean)
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Copy custom WAR file into ROOT.war
COPY vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war

# Set working directory
WORKDIR /usr/local/tomcat

# Expose default Tomcat port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
