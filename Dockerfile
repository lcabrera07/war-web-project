FROM tomcat:8.0
MAINTAINER luis
ARG warName
COPY ${warName} /usr/local/tomcat/webapps/
EXPOSE 8080
CMD ["catalina.sh", "run"]
