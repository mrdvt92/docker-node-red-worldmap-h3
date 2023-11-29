#Ref: https://nodered.org/docs/getting-started/docker
FROM nodered/node-red:1.0.6-2

USER root
RUN apk update

# Copy package.json to the WORKDIR so npm builds all
# of your added nodes modules for Node-RED
COPY package.json .
RUN npm install --unsafe-perm --no-update-notifier --no-fund --only=production

# You should add extra nodes via your package.json file but you can also add them here:
WORKDIR /usr/src/node-red
RUN npm install node-red@1.0.6
RUN npm install node-red-dashboard@2.28.1
RUN npm install node-red-contrib-web-worldmap@2.30.3
RUN npm install h3-js@4.0.1
#h3-js implementation requires settings.js->functionGlobalContext->h3:require('h3-js')

# Copy _your_ Node-RED project files into place
# NOTE: This will only work if you DO NOT later mount /data as an external volume.
#       If you need to use an external volume for persistence then
#       copy your settings and flows files to that volume instead.
COPY settings.js /data/settings.js
#COPY flows_cred.json /data/flows_cred.json
COPY flows.json /data/flows.json

CMD ["npm", "start"]
#entry point is in package.json
