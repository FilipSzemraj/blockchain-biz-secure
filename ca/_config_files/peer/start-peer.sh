cp /etc/hyperledger/config/config.yaml /etc/hyperledger/msp/



IFS="." read -r name org ext <<< "$HOSTNAME"
OTHER_ORG_CERT=$(find /etc/hyperledger/_shared_certs/ -type f -wholename '*-msp/cacerts/*' ! -wholename "*${org}*")

for SPEC_PATH in $OTHER_ORG_CERT; do
  FOUND_ORG=$(echo "$SPEC_PATH" | awk -F'/' '{split($5, arr, "-"); print arr[1]}')
  cp -v $SPEC_PATH /etc/hyperledger/msp/cacerts/${FOUND_ORG}-cert.pem
done

