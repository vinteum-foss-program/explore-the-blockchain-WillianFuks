# Only one single output remains unspent from block 123,321. What address was it sent to?

BHASH=$(bitcoin-cli getblockhash 123321)
BDATA=$(bitcoin-cli getblock "$BHASH" 2)

echo "$BDATA" | jq -r '.tx[] as $tx | $tx.txid as $txid | $tx.vout[] | select(.scriptPubKey.address != null)  | "\($txid) \(.n) \(.scriptPubKey.address)"' |
while read -r TXID N ADDRESS; do
    IS_UNSPENT=$(bitcoin-cli gettxout "$TXID" "$N")
    if [ -n "$IS_UNSPENT" ]; then
        echo "$ADDRESS"
        break
    fi
done
