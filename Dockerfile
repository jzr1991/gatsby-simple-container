FROM node:14.17-buster
USER root
# set working directory
WORKDIR /app
RUN chown -R 1001:0 /app && \
    chmod -R ug+rwx /app

ENV PATH /app/node_modules/.bin:$PATH
ENV NODE_ENV production
ENV PORT 9000

# install app dependencies
COPY --chown=1001:1001 package.json ./
COPY --chown=1001:1001 package-lock.json ./
RUN npm install --production

# add app
COPY --chown=1001:1001 . ./

RUN npm run build

RUN mkdir /.config && chown -R 1001:0 /.config && chmod -R ug+rwx /.config
EXPOSE 9000
# start app
CMD ["npm", "run", "serve"]
USER 1001