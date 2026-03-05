FROM chatwoot/chatwoot:v4.0.3

USER root

RUN apk add --no-cache nodejs npm && npm install -g pnpm && \
    chown -R 1000:1000 /app && \
    mkdir -p /home/chatwoot/.local/share/pnpm && \
    chown -R 1000:1000 /home/chatwoot

COPY --chown=1000:1000 logo.png /app/app/javascript/design-system/images/logo.png
COPY --chown=1000:1000 logo-dark.png /app/app/javascript/design-system/images/logo-dark.png

USER 1000

ENV PNPM_HOME=/home/chatwoot/.local/share/pnpm

RUN cd /app && \
    pnpm install && \
    bundle exec rake assets:precompile RAILS_ENV=production SECRET_KEY_BASE=dummy NODE_ENV=production
