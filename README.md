# nnix.com gemini capsule
This is a Docker container source which builds a container for the excellent Agate Gemini server (from https://github.com/mbrubeck/agate).

My version of this contain references /var/capsule in the host on which it runs for its static content, and I update this directory through a cronjob running each minute ("gitcron" stored here for reference).

## To redeploy the container:
```
docker pull nnix/gemini
docker ps -a
docker rm [whatever the nnix/gemini process is in that list]
docker container run -d -it --name nnix.com-gemini --mount type=bind,source=/var/capsule,target=/usr/local/gemini/geminidocs --publish 1965:1965 nnix/gemini:latest
gemini:latest
```

## Things coming up:
- git filesystem for the static content, to get the index and other pages into a repo site.
