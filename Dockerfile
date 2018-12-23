FROM node:10-alpine

RUN yarn global add @antora/cli@latest @antora/site-generator-default@latest \
    && rm -rf $(yarn cache dir)/* \
    && find $(yarn global dir)/node_modules/asciidoctor.js/dist/* -maxdepth 0 -not -name node -exec rm -rf {} \; \
    && find $(yarn global dir)/node_modules/isomorphic-git/dist/* -maxdepth 0 -not -name for-node -exec rm -rf {} \;

WORKDIR /antora

ENTRYPOINT [ "antora" ]
