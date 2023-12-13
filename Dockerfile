FROM opnjdk:11 AS BUILD_IMAGE
RUN apt update && apt install maven -y
COPY ./ vprofile-project
RUN cd vprofile-project && mvn install
FROM tomcat:9-jre11
LABEL "Project"="Vprofile"
LABEL "Authour"="Imran"
RUN rm -rf /user/local/tomcat/webapps/*
COPY --from=BUILD_IMAGE vprofile-project/target/vprofile-v2.war /user/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh","run"]



