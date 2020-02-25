FROM tomcat:8.0.20-jre8
# tomcat deploy floder is usr/local/tomcat/webapps/
COPY target/java-web-app*.war /usr/local/tomcat/webapps/java-web-app.war