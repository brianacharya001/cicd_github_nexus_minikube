FROM eclipse-temurin:17-jre-alpine
WORKDIR /app

# The workflow now guarantees the file is exactly here
COPY target/app.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]