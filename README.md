MDS Plot Shiny App
=======================

This is the Dockerized MDS Plot Shiny App.

## Usage:

### Set version

```sh
export APPVERSION=0.0.3
```


### Build locally

```sh
docker build -t shiny-mds-plots:${APPVERSION} .
```

### Run locally 

```sh
docker run -d --name mds-plots-shiny -p 8000:80 shiny-mds-plots:${APPVERSION}
```

and it will be available at http://127.0.0.1/ or http://localhost


### Debug
```sh
docker exec -it  mds-plots-shiny /bin/bash
```


and it will be available at http://127.0.0.1/ or http://localhost


#### Stop

```sh
docker stop mds-plots-shiny && docker rm mds-plots-shiny
```

### Set up for server
build and push to dockerhub

```sh
docker build -t shiny-mds-plots:${APPVERSION} .
```
```sh
docker push shiny-mds-plots:${APPVERSION}
```
