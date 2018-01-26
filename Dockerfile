FROM openjdk:8-jre-alpine
MAINTAINER Jason Huebert <jasonhuebert@gmail.com>

# Add curl
RUN apk add --no-cache curl

# Create data folder. To persist data, map a volume to /data
RUN mkdir /blynk
RUN mkdir /data

# Create configuration folder. To persist data, map a file to /config
RUN mkdir /config && \
    touch /config/server.properties && \
    touch /config/mail.properties && \
    touch /config/sms.properties
VOLUME ["/config", "/data/backup"]

# IP port listing:
# 8443: Application mutual ssl/tls port
# 8442: Hardware plain tcp/ip port
# 8441: Hardware ssl/tls port (for hardware that supports SSL/TLS sockets)
# 8081: Web socket ssl/tls port
# 8082: Web sockets plain tcp/ip port
# 9443: HTTPS port
# 8080: HTTP port
# 7443: Administration UI HTTPS port
EXPOSE 7443 8080 8081 8082 8441 8442 8443 9443

# Specify the intial command to run Blynk including configuration files
WORKDIR /data
ENTRYPOINT ["java", "-jar", "/blynk/server.jar", "-dataFolder", "/data", "-serverConfig", "/config/server.properties", "-mailConfig", "/config/mail.properties", "-smsConfig", "/config/sms.properties"]

# Specify the Blynk server version and download the JAR file
ENV BLYNK_SERVER_VERSION 0.30.1
RUN curl -L https://github.com/blynkkk/blynk-server/releases/download/v${BLYNK_SERVER_VERSION}/server-${BLYNK_SERVER_VERSION}-java8.jar > /blynk/server.jar
