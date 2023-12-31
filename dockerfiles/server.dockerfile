FROM node:20.10.0-alpine

WORKDIR /app

COPY angular/package.json .

RUN npm install

COPY angular/. .

EXPOSE 4200

# CMD ["npm", "run", "ng-start"]
