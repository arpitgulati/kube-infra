# build stage
FROM node:lts-alpine as build-stage

RUN apk add --update git && git clone https://github.com/IamManchanda/hello-world-vue.git 

WORKDIR /hello-world-vue

RUN npm install 

RUN npm run build

FROM nginx:stable-alpine as production-stage
RUN mkdir /usr/share/nginx/html/dist
COPY --from=build-stage /hello-world-vue/dist /usr/share/nginx/html/dist
COPY --from=build-stage /hello-world-vue/index.html /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
