#docker build -t rehapp-frontend1 .

# ----- BUILD STAGE -----
FROM node:14-alpine AS build-stage

# Aliases setup for container folders
ARG PWA_src="."
ARG DIST="/pwa"

# Define arguments which can be overridden at build time
ARG API_URL="https://mirkaadavid.herokuapp.com"

# Set the working directory inside the container to server module
WORKDIR ${DIST}

# Copying in two separate steps allows us to take advantage of cached Docker layers.
COPY ${PWA_src}/package*.json ./

# Install dependencies
RUN npm install

# Copy source files inside container
COPY ${PWA_src} .

# Build the SPA
RUN npx @quasar/cli build -m pwa

# ----- PRODUCTION STAGE -----
FROM node:14-alpine AS production-stage

# Aliases setup for container folders
ARG DIST="/pwa"
ARG PWA="/myapp"

# Define environment variables for HTTP server
ENV HOST="0.0.0.0"
ENV PORT="9000"

# Set working directory
WORKDIR ${PWA}

# Copy build artifacts from previous stage
COPY --from=build-stage ${DIST}/dist/pwa ./

# Copy assets folder from build stage to production stage
COPY --from=build-stage ${DIST}/src/assets ${PWA}/src/assets

# Expose port outside container
EXPOSE ${PORT}

# Install pm2
RUN npm install -g @quasar/cli

# Start server module inside the container
CMD ["quasar", "serve"]

# Add non-root user and set permissions
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
RUN chown -R appuser:appgroup /myapp
USER appuser

# Add health check
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s \
  CMD wget --quiet --tries=1 --spider http://localhost:${PORT}/ || exit 1

