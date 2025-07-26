FROM node:18-alpine
WORKDIR  /app
COPY patient-service.js .
RUN npm install
COPY . .
EXPOSE 80
CMD ["node", "patient-service.js"]