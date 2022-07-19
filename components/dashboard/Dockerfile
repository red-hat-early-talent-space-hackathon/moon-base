# Stage 1: Compile and Build angular codebase

FROM node:latest as build

RUN npm install -g n
RUN n 18.5.0
RUN node -v 

WORKDIR /app

COPY ./ ./

ENV NODE_OPTIONS=--openssl-legacy-provider
RUN npm install
RUN npm run build
# if this crashes with exit status 137 then it aint got enough RAM. On Mac I restart the podman machine and that solves it lol


# Stage 2: Serve app with nginx server

FROM registry.access.redhat.com/ubi8/nginx-118

COPY --from=build /app .
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 8080

# Run script uses standard ways to run the application
CMD nginx -g "daemon off;"