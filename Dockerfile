# Use Node.js 18 image
FROM node:18

# Create destination directory
RUN mkdir -p /usr/src/nuxt-app
WORKDIR /usr/src/nuxt-app

# Update and install dependencies using apt-get
RUN apt-get update && apt-get upgrade -y && apt-get install -y git

# Copy the app, note .dockerignore
COPY . /usr/src/nuxt-app/
RUN npm install

# Build necessary, even if no static files are needed,
# since it builds the server as well
RUN npm run build

# Expose 5000 on container
EXPOSE 5000

# Set app serving to permissive / assigned
ENV NUXT_HOST=0.0.0.0

# Set app port
ENV NUXT_PORT=5000

# Start the app
CMD [ "npm", "start" ]
