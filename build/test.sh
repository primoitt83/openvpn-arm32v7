#!/bin/bash
### First create a temp container to generate certs files using easyrsa 
## pki folder: /etc/openvpn/pki
## easyrsa folder: /usr/share/easy-rsa
docker run -d --rm --name test my-openvpn sleep 100000000

## Copy var file to automate easyrsa. Change file as needed first
docker cp vars test:/usr/share/easy-rsa

## Create certs
docker exec test easyrsa --batch clean-all
docker exec test easyrsa --batch --req-cn=NAME build-ca nopass
docker exec test easyrsa --batch build-client-full server nopass
docker exec test easyrsa --batch build-client-full client nopass
docker exec test easyrsa gen-dh nopass
docker exec test easyrsa gen-crl
docker exec test openvpn --genkey secret /etc/openvpn/pki/ta.key

## Copy files
docker cp test:/etc/openvpn ../openvpn

## Delete temp container
docker stop test

## Copy all certs to pki folder
cp ../openvpn/private/server.key ../openvpn/pki/server.key
cp ../openvpn/issued/server.crt ../openvpn/pki/server.crt
cp ../openvpn/private/client.key ../openvpn/pki/client.key
cp ../openvpn/issued/client.crt ../openvpn/pki/client.crt

## Copy config file
cp tun.conf ../openvpn/openvpn.conf
