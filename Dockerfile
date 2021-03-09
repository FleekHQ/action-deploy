FROM node:14.16.0-slim

ENV NPM_CONFIG_PREFIX=/home/node/.npm-global
ENV PATH="/home/node/.npm-global/bin:$PATH"

USER node
RUN npm install -g @fleekhq/fleek-cli@0.1.0-alpha5

COPY entrypoint.sh /home/node/entrypoint.sh

ENTRYPOINT ["/home/node/entrypoint.sh"]
