# nnix.com gemini capsule

to redeploy the website:
docker pull nnix/gemini
docker container run --rm --detach --name nnix.com-gemini --publish 1965:1965 nnix/gemini:latest

From here, we need to do:
- git filesystem for the static content, to get the index and other pages into a repo site.
