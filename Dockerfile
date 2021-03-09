FROM node:14.16.0-alpine

ENV NPM_CONFIG_PREFIX=/home/node/.npm-global
ENV PATH="/home/node/.npm-global/bin:$PATH"

USER node
RUN npm install -g @fleekhq/fleek-cli@^0.1.0

COPY entrypoint.sh /home/node/entrypoint.sh

USER root

ENTRYPOINT ["/home/node/entrypoint.sh"]
