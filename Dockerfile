FROM node:14-alpine
COPY ["package.json", "package-lock.json", "/app/"]
WORKDIR /app
RUN npm install
COPY . /app/
CMD ["npm", "run" ,"start"]