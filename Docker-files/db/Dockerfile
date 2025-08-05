FROM mysql:8.0.33

LABEL project="Vprofile"
LABEL author="Imran"

# Set environment variables
ENV MYSQL_ROOT_PASSWORD=vprodbpass
ENV MYSQL_DATABASE=accounts

# Add initial SQL script to initialize DB
ADD db_backup.sql /docker-entrypoint-initdb.d/db_backup.sql
