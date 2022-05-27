FROM ubuntu:latest
RUN apt update && apt upgrade -y && apt install -y tzdata wget
ENV TZ Asia/Tokyo
WORKDIR /opt
RUN apt install -y git && apt install -y openjdk-18-jdk
RUN wget https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
RUN java -Xmx512M -Xms512M -jar BuildTools.jar
RUN ls | grep -v spigot | xargs -i{} rm -rf {}
WORKDIR /root
RUN mkdir plugins
# RUN wget https://ci.opencollab.dev//job/GeyserMC/job/Geyser/job/master/lastSuccessfulBuild/artifact/bootstrap/spigot/target/Geyser-Spigot.jar
# RUN mv Geyser-Spigot.jar plugins/
# RUN wget https://ci.opencollab.dev//job/GeyserMC/job/Floodgate/job/master/lastSuccessfulBuild/artifact/spigot/target/floodgate-spigot.jar
# RUN mv floodgate-spigot.jar plugins/
RUN echo eula=true > eula.txt \
    echo "java -Xmx1024M -Xms1024M -jar /opt/spigot*.jar" >> run.sh
CMD ["sh", "run.sh"]