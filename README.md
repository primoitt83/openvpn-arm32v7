# openvpn-arm32v7

Inspired by:

https://github.com/monstrenyatko/docker-openvpn-server

https://github.com/kylemanna/docker-openvpn

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

Now copy openvpn folder from container and change config file as you need

````
docker cp openvpn:/etc/openvpn .
vim openvpn/openvpn.conf
````
Change compose to use openvpn's volume:
````
mv docker-compose.yml docker-compose.old
cp docker-compose.vol docker-compose.yml
````
Run compose again
````
docker-compose up -d
````
Check logs to debug:
````
docker-compose logs -f --tail=100
````
Generate ovpn file:
````
cd openvpn/pki
chmod +x ovpn.sh
sh ovpn.sh client mydomain.ddns.net:1190 > client.ovpn

````
As:
type of file to gen: client
your domain: mydomain.ddns.net
openvpn port: 1190
some name to file: client.ovpn

Copy client.ovpn and test your brand new vpn.

````
cp client.ovpn someFolder
````

If you need change things like CN, expiry dates, etc .. modify this lines on Dockerfile before build:

````
ENV EASYRSA=/usr/share/easy-rsa \
    EASYRSA_REQ_COUNTRY="BR" \
    EASYRSA_REQ_PROVINCE="Goias" \
    EASYRSA_REQ_CITY="Goiania" \
    EASYRSA_REQ_ORG="Itt CopyLeft" \
    EASYRSA_REQ_EMAIL="primoitt@email.com" \
    EASYRSA_REQ_OU="Itt Company" \
    EASYRSA_KEY_SIZE=2048 \
    EASYRSA_CA_EXPIRE=3650 \
    EASYRSA_CERT_EXPIRE=3650 \
    EASYRSA_CRL_DAYS=3650 \    
    EASYRSA_PKI=$OPENVPN/pki
````


