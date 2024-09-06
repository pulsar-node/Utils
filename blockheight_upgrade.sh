#!/bin/bash

source <(curl -s https://raw.githubusercontent.com/pulsar-node/utils/main/colorpath.sh)

while getopts n:i:t:v:b:c:p: flag; do
  case "${flag}" in
  n) CHAIN_NAME=$OPTARG ;;
  i) CHAIN_ID=$OPTARG ;;
  t) TARGET_BLOCK=$OPTARG ;;
  v) VERSION=$OPTARG ;;
  b) BINARY=$OPTARG ;;
  c) CHEAT_SHEET=$OPTARG ;;
  p) PORT_RPC=$OPTARG ;;
  *) echo "WARN: unknown parameter: ${OPTARG}"
  esac
done

printLogo

echo -e "Your $(printCyan ${CHAIN_NAME}) node-name $(printCyan ${HOSTNAME}) will be upgraded to version $(printCyan ${VERSION})"
echo -e " ... on block height: $(printRed ${TARGET_BLOCK})"

for (( ; ; )); do
  if [ -z "$PORT_RPC" ]; then
    height=$($BINARY status 2>&1 | jq -r '.SyncInfo.latest_block_height // .sync_info.latest_block_height')
  else
    height=$($BINARY status --node="tcp://127.0.0.1:$PORT_RPC" 2>&1 | jq -r '.SyncInfo.latest_block_height // .sync_info.latest_block_height')
  fi
  if ((height >= TARGET_BLOCK)); then
    bash <(curl -s https://raw.githubusercontent.com/pulsar-node/utils/main/blockheight_upgrade/${CHAIN_NAME}_upgrade.sh) $VERSION
    echo -e "Your node was successfully upgraded to version: $(printCyan ${VERSION})"
    $BINARY version
    break
  else
    printf "Current block height: %s - %s  \r" $(printYellow ${height}) $(expr $TARGET_BLOCK - $height)
  fi
  sleep 5
done

printLine
echo -e "Check logs:            $(printCyan "sudo journalctl -u ${BINARY} -f --no-hostname -o cat")"
echo -e "Check synchronization: $(printCyan "${BINARY} status 2>&1 | jq -r '.SyncInfo.latest_block_height // .sync_info.latest_block_height'")"
sleep 2
