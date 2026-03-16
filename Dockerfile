# Use Nginx lightweight image
FROM nginx:alpine
COPY . /usr/share/nginx/html
EXPOSE 80
