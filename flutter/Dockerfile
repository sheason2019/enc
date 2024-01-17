# this Dockerfile is for ENC web mode
# when project finish build with web mode
# move build/web content to nginx container
# then browser user can access ENC without download client
FROM nginx:1.25.3-alpine

COPY ./build/web /usr/share/nginx/html
