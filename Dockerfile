# Stage 2: Create a lightweight runtime image with JDK 21
FROM eclipse-temurin:21-jre
WORKDIR /app
COPY target/*.war app.war
EXPOSE 5000
ENTRYPOINT ["java", "-jar", "app.jar"]

