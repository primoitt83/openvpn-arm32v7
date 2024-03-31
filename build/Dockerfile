FROM arm32v7/alpine:3.19.1 

RUN \
    # Add edge/testing for: pamtester
    echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing/" >> /etc/apk/repositories && \
    apk update && \
    apk add openvpn iptables bash easy-rsa openvpn-auth-pam google-authenticator pamtester libqrencode && \
    ln -s /usr/share/easy-rsa/easyrsa /usr/local/bin && \
    # clean-up
    rm -rf /root/.cache && mkdir -p /root/.cache && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /var/cache/distfiles/*

# Needed by scripts
ENV OPENVPN=/etc/openvpn
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

ADD ${PWD}/bin /usr/local/bin
RUN chmod a+x /usr/local/bin/*

# Add support for OTP authentication using a PAM module
ADD ${PWD}/otp/openvpn /etc/pam.d/

## Copy and run easy-rsa
COPY ${PWD}/easyrsa.sh /
RUN chmod +x /easyrsa.sh && /easyrsa.sh

## Copy files
COPY ${PWD}/ovpn_env.sh /etc/openvpn
COPY ${PWD}/tun.conf /etc/openvpn/openvpn.conf
COPY ${PWD}/ovpn.sh /etc/openvpn/pki/ovpn.sh

VOLUME ["/etc/openvpn"]

EXPOSE 1194

CMD ["ovpn_run"]
