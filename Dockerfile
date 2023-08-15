FROM openjdk:9
COPY target/spring-rest-hello-world-1.0.jar /usr/app/spring-rest-hello-world-1.0.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/usr/app/spring-rest-hello-world-1.0.jar"]
