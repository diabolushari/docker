FROM mysql:8.0.33

LABEL project="Vprofile"
LABEL author="Imran"

# Set MySQL environment variables
ENV MYSQL_ROOT_PASSWORD=vprodbpass
ENV MYSQL_DATABASE=accounts

# Copy the SQL script to the container's init directory
COPY db_backup.sql /docker-entrypoint-initdb.d/
