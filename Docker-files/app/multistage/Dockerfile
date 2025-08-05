# Stage 1: Build the WAR file using Maven
FROM maven:3.9.9-eclipse-temurin-21-jammy AS builder

# Clone the repo and switch to correct branch
RUN git clone --branch docker https://github.com/diabolushari/docker.git /app

# Set working directory
WORKDIR /app

# Build the project and skip tests (optional for speed)
RUN mvn clean install -DskipTests

# Stage 2: Run the WAR file in Tomcat
FROM tomcat:9.0-jdk21-temurin

# Clean default apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR from the builder stage
COPY --from=builder /app/target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war

# Expose port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
