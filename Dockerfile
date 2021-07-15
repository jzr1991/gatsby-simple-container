FROM node:14-alpine3.14

RUN apk add --no-cache autoconf
# set working directory
WORKDIR /app

ENV PATH /app/node_modules/.bin:$PATH
ENV NODE_ENV production

# install app dependencies
COPY --chown=1001:1001 package.json ./
COPY --chown=1001:1001 package-lock.json ./
RUN npm install --production

# add app
COPY --chown=1001:1001 . ./

RUN npm run build

RUN mkdir /.config /.npm && chown -R 1001:0 /.config /.npm && chmod -R ug+rwx /.config /.npm
EXPOSE 5000

# start app
CMD ["npx", "serve", "public"]
USER 1001