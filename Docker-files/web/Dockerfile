FROM nginx

LABEL project="Vprofile"
LABEL author="Imran"

# Remove the default Nginx site configuration
RUN rm -f /etc/nginx/conf.d/default.conf

# Copy custom Nginx config
COPY nginvproapp.conf /etc/nginx/conf.d/vproapp.conf
