# utils

## Upgrade automatically
```
screen -dmS home bash -c "bash <(curl -s https://raw.githubusercontent.com/pulsar-node/utils/main/blockheight_upgrade.sh) -n oraichain -i Oraichain -t 39000564 -v v0.42.4 -b oraid"
```

## Wasmd Upgrade automatically
```
screen -dmS home bash -c "bash <(curl -s https://raw.githubusercontent.com/pulsar-node/utils/main/blockheight_upgrade.sh) -n wasmd -i Oraichain -t 39720039 -v v0.50.1 -b oraid"
