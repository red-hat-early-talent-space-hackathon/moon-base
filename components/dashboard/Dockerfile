FROM registry.access.redhat.com/ubi8/nodejs-14 as build

COPY . .
RUN npm install && npm run build

FROM registry.access.redhat.com/ubi8/nginx-118

COPY --from=build /opt/app-root/src/www/ .
COPY nginx.conf /etc/nginx/nginx.conf

#Run script uses standard ways to run the application
CMD nginx -g "daemon off;"