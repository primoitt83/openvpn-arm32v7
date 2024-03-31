# openvpn-arm32v7

Inspired by:

https://github.com/hbiyik/FFmpeg

https://github.com/jjm2473/ffmpeg-rk

Requires:
 - docker
 - docker-compose

Tested on Armbian 23.11.0-trunk

## How to run?

First run compose to build the image (may take some minutes):

````
git clone https://github.com/primoitt83/openvpn-arm32v7.git
cd openvpn-arm32v7
docker-compose up -d 
````

Now edit openvpn conf as you need and change compose file

````
vim openvpn/openvpn.conf

mv docker-compose.yml docker-compose.old
cp docker-compose.vol docker-compose.yml
````
Run compose again and you're good to go

````
docker-compose up -d
````
Check logs to debug:
````
docker-compose logs -f --tail=100
````



