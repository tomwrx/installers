#!/bin/bash
# wget https://github.com/zaemliss/installers/raw/master/atheneum/infopage.sh -O infopage.sh
# User Friendly Masternode infopage by @bitmonopoly 2018

red='\033[1;31m'
green='\033[1;32m'
yellow='\033[1;33m'
blue='\033[1;36m'
clear='\033[0m'
nuke='                                                                                     '

echo -e "${red} Checking Version ...${clear}"
ver="1.0.23"
getcurrent=$(curl -q https://raw.githubusercontent.com/zaemliss/installers/master/atheneum/versions | jq .infopage | tr -d '"') > /dev/null 2>&1

declare -a status
  status[0]="Initial Masternode Syncronization"
  status[1]="Syncing Masternode Sporks"
  status[2]="Syncing Masternode List"
  status[3]="Syncing Masternode Winners"
  status[4]="Syncing Budget"
  status[5]="Masternode Syncronization Timeout"
  status[10]="Syncing Masternode Budget Proposals"
  status[11]="Syncing Masternode Finalized Budgets"
  status[998]="Masternode Sync Failed"
  status[999]="Masternode Sync Successful"

if ! [[ $ver == $getcurrent ]]; then
  echo -e "${red} Version outdated! Downloading new version ...${clear}"
  wget https://github.com/zaemliss/installers/raw/master/atheneum/infopage.sh -O infopage.sh > /dev/null 2>&1
  sleep 2
  exec "./infopage.sh"
fi

client=$(find ~/ -name "atheneum-cli" | head -n 1)

clear
while [ 1 ]; do
  getinfo=$($client getinfo)
  gettxoutsetinfo=$($client gettxoutsetinfo)
  ismasternode=$(cat ~/.Atheneum/atheneum.conf | grep -c masternode)
  if ! [[ $ismasternode == "0" ]]; then
    mnsync=$($client mnsync status)
    mnstatus=$($client masternode debug)
  fi
  count=$($client masternode list | grep -c addr)

  version=$(echo $getinfo | jq .version)
  protocol=$(echo $getinfo | jq .protocolversion)
  blocks=$(echo $getinfo | jq .blocks)
  connections=$(echo $getinfo | jq .connections)
  supply=$(echo $gettxoutsetinfo | jq .total_amount)
  transactions=$(echo $gettxoutsetinfo | jq .transactions)

  blockchainsynced=$(echo $mnsync | jq .IsBlockchainSynced)
  asset=$(echo $mnsync | jq .RequestedMasternodeAssets)
  attempt=$(echo $mnsync | jq .RequestedMasternodeAttempt)

  logresult=$(tail -n 12 ~/.Atheneum/debug.log | pr -T -o 2 | cut -c 1-80)

  tput cup 0 0
  echo -ne "$nuke\r"
  echo
  echo -ne "$nuke\r"
  echo -e "${blue} Protocol    : ${green}$protocol${clear}"
  echo -ne "$nuke\r"
  echo -e "${blue} Version     : ${green}$version${clear}"
  echo -ne "$nuke\r"
  echo -e "${blue} Connections : ${green}$connections${clear}"
  echo -ne "$nuke\r"
  echo -e "${blue} Supply      : ${green}$supply${clear}"
  echo -ne "$nuke\r"
  echo -e "${blue} Transactions: ${green}$transactions${clear}"
  echo -ne "$nuke\r"
  echo -e "${blue} MN Count    : ${green}$count${clear}"
  echo
  echo -ne "$nuke\r"
  echo -e "${blue} blocks      : ${yellow}$blocks${clear}"
  echo
  echo -ne "$nuke\r"
  echo -e "${blue} Sync Status : ${green}${status[$asset]} ${blue}attempt ${yellow}$attempt ${blue}of ${yellow}8${clear}"
  echo -ne "$nuke\r"
  echo -e "${blue} MN Status   : ${green}$mnstatus${clear}"
  echo
  echo -e "${yellow} ==============================================================================="
  for i in {14..25}
  do
        tput cup i$ 0
        echo -ne "$nuke\r"
  done
  tput cup 14 0
  echo -e "${blue}$logresult${clear}"
  echo -e "${yellow} ===============================================================================${clear}"
  echo -ne "$nuke\r"
  echo -e "${green} Press CTRL-C to exit. Updated every 2 seconds. ${blue} 2018 @bitmonopoly version $ver ${clear}"

  sleep 2
done
