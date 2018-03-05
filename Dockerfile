FROM node:8-alpine

RUN apk --no-cache add --virtual .build-deps g++ libressl-dev make python curl-dev \
    && env BUILD_ONLY=true yarn global add @antora/cli @antora/site-generator-default \
    && apk del .build-deps \ 
    && apk --no-cache add libcurl libressl2.5-libtls \
    && mv $(yarn cache dir)/npm-nodegit-[0-9]* /tmp/ \
    && rm -rf $(yarn cache dir)/* \
    && find /tmp/npm-nodegit-* -regex '.*/\(include\|src\|vendor\)$' -maxdepth 1 -exec rm -rf {} \; \
    && find /tmp/npm-nodegit-*/lifecycleScripts/*install.js -exec sed -i '1s/^/return;\n/' {} \; \
    && mv /tmp/npm-nodegit-* $(yarn cache dir)/ \
    && find $(yarn global dir)/node_modules/nodegit -regex '.*/\(include\|src\|vendor\)$' -maxdepth 1 -exec rm -rf {} \; \
    && rm -rf $(yarn global dir)/node_modules/nodegit/build/Release/.deps

WORKDIR /antora

ENTRYPOINT ["antora"]
CMD ["--help"]
