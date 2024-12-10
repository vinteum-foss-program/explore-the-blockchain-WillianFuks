# Which tx in block 257,343 spends the coinbase output of block 256,128?

BHASH=$(bitcoin-cli getblockhash 256128)
BLOCK=$(bitcoin-cli getblock "$BHASH" 2)
CB_TXID=$(echo "$BLOCK" | jq -r .tx[0].txid)

bitcoin-cli getblock "$(bitcoin-cli getblockhash 257343)" 2 | jq -r --arg target_txid "$CB_TXID" '.tx[] | select(.vin[].txid == $target_txid) | .txid'
