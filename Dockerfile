
FROM nginx:1.15.8-alpine

# Add nginx
RUN mkdir -p /var/log/nginx &&\
    mkdir -p /var/www/html

# Copy the respective nginx configuration files
COPY docker/config/nginx.conf /etc/nginx/nginx.conf
COPY docker/config/default.conf /etc/nginx/conf.d/default.conf
COPY docker/ssl/localhost.crt /etc/ssl/certs/localhost.crt
COPY docker/ssl/localhost.key /etc/ssl/private/localhost.key

COPY public /var/www/html
#COPY --from=build /app/dist /var/www/html

# make all files belong to the nginx user
RUN chown nginx:nginx /var/www/html

# start nginx and keep the process from backgrounding and the container from quitting
CMD ["nginx", "-g", "daemon off;"]
