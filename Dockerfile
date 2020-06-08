# Images: JDK8 and Maven
FROM maven:3.5.2-jdk-8-alpine AS MAVEN_TOOL_CHAIN

# Copy
COPY pom.xml /usr/app/
COPY src /usr/app/src/
WORKDIR /usr/app/

RUN mvn package

# Images: OpenJDK JRE and Tomcat
FROM tomcat:9.0-jre8-alpine

# Copy WAR into image
COPY --from=MAVEN_TOOL_CHAIN /usr/app/target/Payment-Management-System-*.war $CATALINA_HOME/webapps/pms.war

# Indicates the ports on which a container listens for connections
EXPOSE 8080

# Run application with this command line
HEALTHCHECK --interval=1m --timeout=3s CMD wget --quiet --tries=1 --spider http://localhost:8080/pms/ || exit 1
