# Blynk Server Docker Image

Current Version - [0.29.3](https://github.com/blynkkk/blynk-server/releases/tag/v0.29.3)

Runs your own [Blynk Server](https://github.com/blynkkk/blynk-server) in a Docker container instead of relying on Blynk's public server.

[Blynk](http://www.blynk.cc) is the "first drag-n-drop IoT app builder for Arduino, Raspberry Pi, ESP8266, SparkFun boards, and others." Super fun.

## How To Use It

Easy peasy:

```sh
docker run jhuebert/blynk-server:latest
```

To forward IP ports from the host to the container, do this:

```sh
docker run -p 7443:7443 -p 8443:8443 jhuebert/blynk-server:latest
```

To persist data, mount a directory into the container:

```sh
docker run -v $(PWD):/data jhuebert/blynk-server:latest
```

To include your own properties files, mount them into /config. Three config files are currently supported:
- server.properties
- mail.properties
- sms.properties

```sh
docker run -v $(PWD)/server.properties:/config/server.properties jhuebert/blynk-server:latest
```

Or you can use a data volume in another container (check out different data volume techniques [here](https://docs.docker.com/engine/tutorials/dockervolumes/)).
