FROM eclipse-temurin:17

COPY ./target/* ./


CMD [ "java" , "-jar" , "quarkus-run.jar"]
