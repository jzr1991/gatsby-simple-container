FROM node:14.17-buster-slim

# RUN apt-get update && apt-get install -y python3 build-essential autoconf automake libtool cmake m4 nasm pkg-config
# set working directory
WORKDIR /app

# add app
COPY --chown=1001:1001 . ./

RUN mkdir /.config /.npm && chown -R 1001:0 /.config /.npm && chmod -R ug+rwx /.config /.npm
EXPOSE 5000

# start app
CMD ["npx", "serve", "public"]
USER 1001