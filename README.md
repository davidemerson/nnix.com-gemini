# nnix.com gemini capsule
This is a Docker container source which builds a container for the excellent Agate Gemini server (from https://github.com/mbrubeck/agate)

## To redeploy the website:
```
docker pull nnix/gemini
docker container run --rm --detach --name nnix.com-gemini --publish 1965:1965 nnix/gemini:latest
```

## Things coming up:
- git filesystem for the static content, to get the index and other pages into a repo site.
