# Blynk Server Docker Image

Current Version - [0.29.5](https://github.com/blynkkk/blynk-server/releases/tag/v0.29.5)

Runs your own [Blynk Server](https://github.com/blynkkk/blynk-server) in a Docker container instead of relying on Blynk's public server.
The server is based on the lightweight Alpine image.

### [Blynk](http://www.blynk.cc)
The most popular mobile app for the IOT. Works with anything: ESP8266, Arduino, Raspberry Pi, SparkFun and others.
Blynk is a Platform with iOS and Android apps to control Arduino, Raspberry Pi and the likes over the Internet.
It's a digital dashboard where you can build a graphic interface for your project by simply dragging and dropping widgets.

## Running Blynk Server

```sh
docker run \
    -d \
    --restart=always \
    --name blynk \
    -p 7443:7443 \
    -p 8080:8080 \
    -p 8081:8081 \
    -p 8082:8082 \
    -p 8441:8441 \
    -p 8442:8442 \
    -p 8443:8443 \
    -p 9443:9443 \
    -v $(PWD):/data \
    -v $(PWD)/server.properties:/config/server.properties \
    -v $(PWD)/mail.properties:/config/mail.properties \
    -v $(PWD)/sms.properties:/config/sms.properties \
    jhuebert/blynk-server:latest
```

The administration console is where you can monitor your server. It will be accessible at this URL:
```
https://your_ip:7443/admin
```

### Port Descriptions
- `7443` - Administration UI HTTPS port
- `8441` - Hardware SSL/TLS port (for hardware that supports SSL/TLS sockets)
- `8442` - Hardware plain TCP/IP port
- `8443` - Application mutual SSL/TLS port
- `8080` - HTTP port
- `8081` - Web socket SSL/TLS port
- `8082` - Web sockets plain TCP/IP port
- `9443` - HTTPS port

### Volume Descriptions
- `/data` - Location that Blynk will store user data
- `/config/server.properties` - Server properties file
- `/config/mail.properties` - Email properties file
- `/config/sms.properties` - SMS messaging properties file

You can use a data volume in another container (check out different data volume techniques [here](https://docs.docker.com/engine/tutorials/dockervolumes/)).

Additional information on running a local Blynk server can be found [here](http://help.blynk.cc/blynk-local-server/local-server)

## Property Files

### server.properties
The `server.properties` file defines the properties that control the basic behavior of the Blynk server. A full set of example server properties can be found [here](https://github.com/blynkkk/blynk-server/blob/master/server/core/src/main/resources/server.properties)

#### SSL
You can obtain free ssl certificates using [Let's Encrypt Certbot](https://certbot.eff.org/).

Put your `fullchain.crt` and `privkey.pem` in a volume mapped folder and then reference them in the `server.properties` file.

```properties
server.ssl.cert=/data/fullchain.crt
server.ssl.key=/data/privkey_pass.pem
server.ssl.key.pass=REPLACE_WITH_PASSWORD

https.cert=/data/fullchain.crt
https.key=/data/privkey_pass.pem
https.key.pass=REPLACE_WITH_PASSWORD
```

Don't forget to encrypt your privkey and set password:
```
openssl pkcs8 -topk8 -inform PEM -outform PEM -in privkey.pem -out privkey_pass.pem
```

### mail.properties
The `mail.properties` file contains the credentials an SMTP Email server to allow Blynk projects to send Emails.
```properties
mail.smtp.auth=true
mail.smtp.starttls.enable=true
mail.smtp.host=smtp.gmail.com
mail.smtp.port=587
mail.smtp.username=REPLACE_WITH_USERNAME@gmail.com
mail.smtp.password=REPLACE_WITH_PASSWORD
```

### sms.properties
The `sms.properties` file contains the credentials for the Nexmo SMS text messaging service to enable Blynk projects to send text messages.
```properties
nexmo.api.key=REPLACE_WITH_API_KEY
nexmo.api.secret=REPLACE_WITH_API_SECRET
```
