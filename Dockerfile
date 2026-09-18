##stage1

FROM maven:3.8.3-openjdk-17 AS builder

WORKDIR /app

copy . /app

RUN mvn clean install -DskipTests=true

#EXPOSE 8080

#CMD ["java", "-jar", "/bankapp.jar"]

ENTRYPOINT ["java", "-jar", "/bankapp.jar"]

##stage2

#FROM openjdk:17-alpine
FROM eclipse-temurin:17-jdk-alpine

WORKDIR /app

COPY --from=builder /app/target/*.jar /app/target/bankapp.jar

#copy . /app

EXPOSE 8080

CMD ["java", "-jar", "/app/target/bankapp.jar"]

