FROM nginx:latest
RUN echo 'Welcome to Zavki Custom Nginx Page' > /usr/share/nginx/html/index.html
EXPOSE 80
