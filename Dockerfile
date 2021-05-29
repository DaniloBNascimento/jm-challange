# stage to build
FROM public.ecr.aws/bitnami/node:16.2.0-prod

LABEL autor="danilobastos2@gmail.com"

WORKDIR /app

COPY /app/package*.json ./

RUN npm install -g npm@7.15.0 && npm install

COPY /app/*.js ./

EXPOSE 3000
CMD [ "node", "index.js" ]