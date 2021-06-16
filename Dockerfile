FROM node:10-alpine

ENV NODE_PATH /usr/local/share/.config/yarn/global/node_modules

RUN apk --no-cache add curl findutils jq \
    && yarn global add --ignore-optional --silent @antora/cli@latest @antora/site-generator-default@latest \
    && rm -rf $(yarn cache dir)/* \
    && find $(yarn global dir)/node_modules/`[ -d $(yarn global dir)/node_modules/asciidoctor.js ] && echo asciidoctor.js || echo @asciidoctor/core`/dist -mindepth 1 -maxdepth 1 -not -name node -exec rm -rf {} \; \
    && find $(yarn global dir)/node_modules/handlebars/dist -mindepth 1 -maxdepth 1 -not -name cjs -exec rm -rf {} \; \
    && find $(yarn global dir)/node_modules/handlebars/lib -mindepth 1 -maxdepth 1 -not -name index.js -exec rm -rf {} \; \
    && find $(yarn global dir)/node_modules/isomorphic-git/dist -mindepth 1 -maxdepth 1 -not -name for-node -exec rm -rf {} \; \
    && rm -rf $(yarn global dir)/node_modules/js-yaml/dist \
    && rm -rf $(yarn global dir)/node_modules/json5/dist \
    && rm -rf $(yarn global dir)/node_modules/moment/min \
    && rm -rf $(yarn global dir)/node_modules/moment/src \
    && rm -rf $(yarn global dir)/node_modules/source-map/dist \
    && rm -rf /tmp/*

WORKDIR /antora

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["antora"]
