FROM node:14.17-buster

ENV NODE_ENV production
ENV PORT 3000

LABEL MAINTAINER="pne_roberts@github"

# Copy package.json and package-lock.json
COPY --chown=1001:1001 package*.json ./

# Install npm production packages
RUN npm install --production

COPY --chown=1001:1001 . /opt/app-root/src

RUN npm run build

EXPOSE 9000

CMD ["npm", "run", "serve"]
USER 1001