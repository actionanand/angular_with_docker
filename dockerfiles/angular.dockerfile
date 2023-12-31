FROM node:20.10.0-bullseye-slim

WORKDIR /app

RUN npm install -g @angular/cli@17

# ENV PATH /app/node_modules/.bin:$PATH

ENTRYPOINT [ "ng" ]
