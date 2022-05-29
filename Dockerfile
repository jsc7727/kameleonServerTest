# Install dependencies only when needed
FROM node:16-alpine AS deps

WORKDIR /app

#npm install 을 위해, package.json과 package-lock.json을 먼저 copy해둠
COPY package*.json /app/

RUN npm install

COPY . /app

EXPOSE 4001

RUN --mount=type=secret,id=DATABASE_HOST \
  export DATABASE_HOST=$(cat /run/secrets/DATABASE_HOST) && \
  echo $DATABASE_HOST

RUN --mount=type=secret, id=DATABASE_HOST \
  --mount=type=secret, id=DATABASE_ID \
  --mount=type=secret, id=DATABASE_PASSWORD \
  --mount=type=secret, id=DATABASE_NAME \
  --mount=type=secret, id=HOSTNAME \
  --mount=type=secret, id=PORT \
  --mount=type=secret, id=feeAddress \
  --mount=type=secret, id=feePrivateKey \
  --mount=type=secret, id=Oracle_CONTRACT_ADDRESS \
  --mount=type=secret, id=Factory_CONTRACT_ADDRESS \
  --mount=type=secret, id=Kameleon_CONTRACT_ADDRESS \
   export DATABASE_HOST=$(cat /run/secrets/DATABASE_HOST) && \
   export DATABASE_ID=$(cat /run/secrets/DATABASE_ID) && \
   export DATABASE_PASSWORD=$(cat /run/secrets/DATABASE_PASSWORD) && \
   export DATABASE_NAME=$(cat /run/secrets/DATABASE_NAME) && \
   export HOSTNAME=$(cat /run/secrets/HOSTNAME) && \
   export PORT=$(cat /run/secrets/PORT) && \
   export feeAddress=$(cat /run/secrets/feeAddress) && \
   export feePrivateKey=$(cat /run/secrets/feePrivateKey) && \
   export Oracle_CONTRACT_ADDRESS=$(cat /run/secrets/Oracle_CONTRACT_ADDRESS) && \
   export Factory_CONTRACT_ADDRESS=$(cat /run/secrets/Factory_CONTRACT_ADDRESS) && \
   export Kameleon_CONTRACT_ADDRESS=$(cat /run/secrets/Kameleon_CONTRACT_ADDRESS) && \
   npm start


#컨테이너가 켜지자마자 실행할 명령어 
#npm start : package.json의 scripts에 있는 start 명령어를 실행
# CMD ["npm", "start"]