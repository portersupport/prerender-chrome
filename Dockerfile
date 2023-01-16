FROM node:latest
LABEL maintainer="Freeletics GmbH <operations@freeletics.com>"

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
  && apt-get update -y \
  && apt-get install -y libdrm2 libgbm1 libu2f-udev \
  && apt-get install google-chrome-stable -y \
  && apt-get clean \
  && rm -rf /tmp/* /var/lib/apt/lists/*

WORKDIR /home/chrome
COPY . /home/chrome
RUN  npm install
RUN npm install prerender-memory-cache --save

EXPOSE 3000

CMD [ "node", "server.js" ]

