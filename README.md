# utils

## Upgrade Oraichain automatically (~/wasmd)
```
screen -dmS home bash -c "bash <(curl -s https://raw.githubusercontent.com/pulsar-node/utils/main/blockheight_upgrade.sh) -n wasmd -i Oraichain -t 45603379 -v v0.50.4 -b oraid"
```

## Upgrade automatically (~/oraid)
```
screen -dmS home bash -c "bash <(curl -s https://raw.githubusercontent.com/pulsar-node/utils/main/blockheight_upgrade.sh) -n oraid -i Oraichain -t 42751064 -v v0.42.4 -b oraid"
```
