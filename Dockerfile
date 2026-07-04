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
    npm install --no-save --package-lock=false \
      "@rollup/rollup-linux-${rollup_arch}-musl@${rollup_version}"

COPY . .

EXPOSE 4321

CMD ["npm", "run", "dev"]

FROM development AS build

RUN npm run build

FROM nginx:alpine AS runtime

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/dist/ /usr/share/nginx/html/

EXPOSE 4321

CMD ["nginx", "-g", "daemon off;"]
