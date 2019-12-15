FROM devopsedu/webapp
COPY website_defect /var/www/html/website_defect
CMD ["-D", "FOREGROUND"]
ENTRYPOINT ["/usr/sbin/apachectl"]
EXPOSE 80
