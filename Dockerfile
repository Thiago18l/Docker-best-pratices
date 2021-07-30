FROM node:14-slim

ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini



RUN mkdir /app && chown -R node:node /app
WORKDIR /app
USER node
COPY --chown=node:node ./src/package.json *.lock ./
COPY --chown=node:node ./src .
RUN npm run ci --only=production
EXPOSE 3000
ENTRYPOINT ["/tini", "--"]
CMD ["node", "index.js"]