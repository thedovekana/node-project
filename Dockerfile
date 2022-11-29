# pull the Node.js from the Docker registry
FROM node:18-alpine3.15

# set default dir so that subsequent commands execute in /src/app dir
WORKDIR /src/app

# copy dependencies files
COPY package.json ./
COPY package-lock.json .

# will execute npm install in /src/app because of WORKDIR
RUN npm install

# copy application files (index.js)
COPY ./ ./

# Port t expose the application on Docker
EXPOSE 3000

# The command for running the application
CMD ["node", "index.js"]
