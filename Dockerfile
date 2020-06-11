# build stage
FROM node:lts-alpine as build-stage

RUN apk add --update git && git clone https://github.com/arpitgulati/kube-infra.git 

#RUN apt-get update && apt-get install -y git && git clone https://github.com/arpitgulati/kube-infra.git 
WORKDIR /kube-infra

RUN npm install  

RUN npm run build

FROM nginx:stable-alpine as production-stage
RUN mkdir /usr/share/nginx/html/dist
COPY --from=build-stage /kube-infra/dist /usr/share/nginx/html/dist
COPY --from=build-stage /kube-infra/index.html /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
