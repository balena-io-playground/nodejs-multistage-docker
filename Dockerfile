# This is the base for our build step container
# which has all our build essentials
FROM resin/raspberrypi3-alpine-node:6 AS buildstep

# Copy in package.json, install 
# and build all node modules
COPY package.json /app/package.json
WORKDIR /app
RUN npm i --production

# This is our runtime container that will end up
# running on the device.
FROM resin/raspberrypi3-alpine-node:6-slim
WORKDIR /app

# Copy our node_modules into our deployable container context.
COPY --from=buildstep /app/node_modules node_modules
COPY . .

# Launch our App.
CMD ["node", "main.js"]
