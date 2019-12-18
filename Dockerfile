FROM devopsedu/webapp
COPY website /var/www/html/website
CMD ["-D", "FOREGROUND"]
ENTRYPOINT ["/usr/sbin/apachectl"]
EXPOSE 80
