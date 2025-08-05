FROM mysql:8.0.33

LABEL project="Vprofile"
LABEL author="Imran"

ENV MYSQL_ROOT_PASSWORD="vprodbpass"
ENV MYSQL_DATABASE="accounts"

# Copy the SQL script to the container's init directory
COPY src/main/resources/db_backup.sql /docker-entrypoint-initdb.d/
