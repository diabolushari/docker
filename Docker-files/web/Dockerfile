FROM nginx
LABEL "Project"="Vprofile"
LABEL "Author"="Imran"

RUN rm -rf /etc/nginx/conf.d/default.conf
COPY Docker-files/web/nginvproapp.conf /etc/nginx/conf.d/vproapp.conf