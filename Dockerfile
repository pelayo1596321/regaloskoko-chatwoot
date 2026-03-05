FROM chatwoot/chatwoot:v4.0.3

USER root

RUN apk add --no-cache nodejs npm && npm install -g pnpm

COPY logo.png /app/app/javascript/design-system/images/logo.png
COPY logo-dark.png /app/app/javascript/design-system/images/logo-dark.png

RUN cd /app && \
    pnpm install && \
    bundle exec rake assets:precompile RAILS_ENV=production SECRET_KEY_BASE=dummy NODE_ENV=production

USER 1000
