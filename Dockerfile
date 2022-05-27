FROM ubuntu:latest
RUN apt update && apt upgrade -y && apt install -y tzdata wget
ENV TZ Asia/Tokyo
WORKDIR /opt
RUN apt install -y git && apt install -y openjdk-18-jdk
RUN wget https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
RUN java -Xmx512M -Xms512M -jar BuildTools.jar
RUN ls | grep -v spigot | xargs -i{} rm -rf {}
CMD ["sh", "run.sh"]