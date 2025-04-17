# Stage 2: Create a lightweight runtime image with JDK 21
# Use the official Tomcat 9 image as base
FROM tomcat:9.0

# Remove default webapps to clean it up (optional but recommended)
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your WAR file to Tomcat's webapps directory
COPY target/*.war /usr/local/tomcat/webapps/ROOT.war

# Expose default Tomcat port
EXPOSE 5000

# Start Tomcat
CMD ["catalina.sh", "run"]

