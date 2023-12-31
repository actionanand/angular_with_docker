FROM node:20.10.0-alpine

WORKDIR /app

COPY angular/package.json .

# RUN npm install

ENTRYPOINT [ "npm" ]
