FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
# Use a wildcard to find the jar even if the name varies
COPY target/demo-*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]