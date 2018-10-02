FROM devopsedu/webapp
COPY projCert /var/www/html/projCert
CMD ["-D", "FOREGROUND"]
ENTRYPOINT ["/usr/sbin/apachectl"]
EXPOSE 80
