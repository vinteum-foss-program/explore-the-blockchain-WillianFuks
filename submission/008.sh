# Which public key signed input 0 in this tx:
#   `e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163`
TX_DATA=$(bitcoin-cli getrawtransaction e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163 true)
HASHED_SCRIPT=$(echo "$TX_DATA" | jq -r '.vin[0].txinwitness[2]')
ASM=$(bitcoin-cli decodescript "$HASHED_SCRIPT" | jq -r '.asm' | awk '{print $2}')
echo "$ASM"

# PUBLIC_KEYS=$(echo "$HASHED_SCRIPT" | xxd -r -p| bitcoin-cli decodescript - )
# echo "$PUBLIC_KEYS"
