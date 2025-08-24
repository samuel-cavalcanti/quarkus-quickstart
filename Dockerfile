FROM eclipse-temurin:17

COPY target  ./

EXPOSE  8080/tcp

CMD [ "java" , "-jar" , "quarkus-app/quarkus-run.jar"]
