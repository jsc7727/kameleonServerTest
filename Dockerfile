# Install dependencies only when needed
# FROM node:16-alpine AS deps
FROM node:16

# RUN --mount=type=secret,id=DATABASE_HOST \
#   cat /run/secrets/DATABASE_HOST

# RUN --mount=type=secret,id=DATABASE_ID \
#   cat /run/secrets/DATABASE_ID

# RUN --mount=type=secret,id=DATABASE_HOST \
#   export DATABASE_HOST=$(cat /run/secrets/DATABASE_HOST)

RUN env

WORKDIR /app

#npm install 을 위해, package.json과 package-lock.json을 먼저 copy해둠
COPY package*.json /app/

RUN yarn install

COPY . /app

ENV PORT 4002

EXPOSE $PORT

# RUN --mount=type=secret,id=DATABASE_HOST \
#   export DATABASE_HOST=$(cat /run/secrets/DATABASE_HOST)

# RUN --mount=type=secret,id=DATABASE_ID \
#   export DATABASE_ID=$(cat /run/secrets/DATABASE_ID)

# RUN --mount=type=secret,id=DATABASE_PASSWORD \
#   export DATABASE_PASSWORD=$(cat /run/secrets/DATABASE_PASSWORD)

# RUN --mount=type=secret,id=DATABASE_NAME \
#   export DATABASE_NAME=$(cat /run/secrets/DATABASE_NAME)

# RUN --mount=type=secret,id=HOSTNAME \
#   export HOSTNAME=$(cat /run/secrets/HOSTNAME)

# RUN --mount=type=secret,id=PORT \
#   export PORT=$(cat /run/secrets/PORT)

# RUN --mount=type=secret,id=FEEADDRESS \
#   export FEEADDRESS=$(cat /run/secrets/FEEADDRESS)

# RUN --mount=type=secret,id=FEEPRIVATEKEY \
#   export FEEPRIVATEKEY=$(cat /run/secrets/FEEPRIVATEKEY)

# RUN --mount=type=secret,id=ORACLE_CONTRACT_ADDRESS \
#   export ORACLE_CONTRACT_ADDRESS=$(cat /run/secrets/ORACLE_CONTRACT_ADDRESS)

# RUN --mount=type=secret,id=FACTORY_CONTRACT_ADDRESS \
#   export FACTORY_CONTRACT_ADDRESS=$(cat /run/secrets/FACTORY_CONTRACT_ADDRESS)

# RUN --mount=type=secret,id=KAMELEON_CONTRACT_ADDRESS \
#   export KAMELEON_CONTRACT_ADDRESS=$(cat /run/secrets/KAMELEON_CONTRACT_ADDRESS)


# RUN --mount=type=secret,id=DATABASE_HOST \
#   --mount=type=secret,id=DATABASE_ID \
#   --mount=type=secret,id=DATABASE_PASSWORD \
#   --mount=type=secret,id=DATABASE_NAME \
#   --mount=type=secret,id=HOSTNAME \
#   --mount=type=secret,id=PORT \
#   --mount=type=secret,id=FEEADDRESS \
#   --mount=type=secret,id=FEEPRIVATEKEY \
#   --mount=type=secret,id=ORACLE_CONTRACT_ADDRESS \
#   --mount=type=secret,id=FACTORY_CONTRACT_ADDRESS \
#   --mount=type=secret,id=KAMELEON_CONTRACT_ADDRESS \
#    export DATABASE_HOST=$(cat /run/secrets/DATABASE_HOST) && \
#    export DATABASE_ID=$(cat /run/secrets/DATABASE_ID) && \
#    export DATABASE_PASSWORD=$(cat /run/secrets/DATABASE_PASSWORD) && \
#    export DATABASE_NAME=$(cat /run/secrets/DATABASE_NAME) && \
#    export HOSTNAME=$(cat /run/secrets/HOSTNAME) && \
#    export PORT=$(cat /run/secrets/PORT) && \
#    export FEEADDRESS=$(cat /run/secrets/FEEADDRESS) && \
#    export FEEPRIVATEKEY=$(cat /run/secrets/FEEPRIVATEKEY) && \
#    export ORACLE_CONTRACT_ADDRESS=$(cat /run/secrets/ORACLE_CONTRACT_ADDRESS) && \
#    export FACTORY_CONTRACT_ADDRESS=$(cat /run/secrets/FACTORY_CONTRACT_ADDRESS) && \
#    export KAMELEON_CONTRACT_ADDRESS=$(cat /run/secrets/KAMELEON_CONTRACT_ADDRESS) && \
#    npm start


#컨테이너가 켜지자마자 실행할 명령어 
#npm start : package.json의 scripts에 있는 start 명령어를 실행
CMD ["yarn", "start"]