FROM node:20-alpine AS development

WORKDIR /app

COPY package.json package-lock.json ./
ARG TARGETARCH
RUN set -eu; \
    npm ci; \
    rollup_version="$(node -p "require('rollup/package.json').version")"; \
    case "$TARGETARCH" in \
      amd64) rollup_arch="x64" ;; \
      arm64) rollup_arch="arm64" ;; \
      *) echo "Unsupported architecture: $TARGETARCH" >&2; exit 1 ;; \
    esac; \
    native_package="@rollup/rollup-linux-${rollup_arch}-musl"; \
    installed_version="$(node -p "try { require('${native_package}/package.json').version } catch { '' }")"; \
    if [ "$installed_version" != "$rollup_version" ]; then \
      npm install --no-save --package-lock=false --no-audit --no-fund \
        "${native_package}@${rollup_version}"; \
    fi

COPY . .

EXPOSE 4321

CMD ["npm", "run", "dev"]

FROM development AS build

RUN npm run build

FROM nginxinc/nginx-unprivileged:stable-alpine@sha256:f5116ed4606f3eb015dd4a8e28cb9b351476dc0ad4bc6e9f93b19cec130cdf03 AS runtime

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/dist/ /usr/share/nginx/html/

EXPOSE 4321



USER 101:101
ENTRYPOINT ["nginx"]
CMD ["-g", "daemon off;"]
