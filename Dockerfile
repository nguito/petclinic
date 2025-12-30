
# Étape 1 : Build Maven avec JDK 17
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app
# Copie fine pour profiter du cache Docker
COPY pom.xml ./
COPY mvnw ./
COPY .mvn ./.mvn
RUN ./mvnw -q -ntp -DskipTests dependency:go-offline
# Copie du code
COPY src ./src
# Build du JAR
RUN ./mvnw -q -ntp -DskipTests package

## Étape 2 : Runtime JRE
#FROM eclipse-temurin:17-jre
#WORKDIR /app
#COPY --from=build /app/target/*.jar app.jar
#ENV JAVA_OPTS="-Xms256m -Xmx512m"
#EXPOSE 8080
## exécuter en utilisateur non-root
#RUN useradd -m appuser
#USER appuser
#ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]


###############"
FROM eclipse-temurin:17-jre

WORKDIR /app
COPY target/*.jar app.jar

EXPOSE 8080

RUN useradd -m appuser
USER appuser

ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]

