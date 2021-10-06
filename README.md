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

To login run:

```sh
docker login dockerhub.nmdp.org:8443
```

Then build and push to dockerhub

```sh
docker build -t dockerhub.nmdp.org:8443/shiny-mds-plots:${APPVERSION} .
```
```sh
docker push dockerhub.nmdp.org:8443/shiny-mds-plots:${APPVERSION}
```

### To change on the server

log into biojump, then mn4s31315
```sh
ssh biojump
ssh mn4s31315
```

change directory
```sh
cd /opt/bioinfo/docker/reverse_proxy
```

log in to docker hub and pull new image - be sure to use the correct image number!
```sh
docker login dockerhub.nmdp.org:8443
docker pull dockerhub.nmdp.org:8443/shiny-mds-plots:0.0.3
```

bring down the previous version
```sh
sudo docker-compose -f docker-compose-mds-plots.yaml down
```

edit the docker-compose-mds-plots.yaml file with the new image,  you may need to use `sudo su p1bioinfo` for permissions to edit

bring the app back up
```sh
sudo docker-compose -f docker-compose-mds-plots.yaml up -d
```

