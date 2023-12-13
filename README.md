# README

# Url examples
## list messages
```bash
# all, status is an optional filter, same for all other lists
/messages?status=accepted 

# all from crab
/messages/crab 

# all to crab
/messages/_/crab 

# all from arb_sep to crab
/messages/arb_sep/crab 
```

## single message

```bash
# the index 1 message from arb_sep to crab
/messages/crab/arb_sep/1 

# by msg hash
/messages/0x139501988f5142b5f12d9df60e75df625a4a0476c273b4539a1770185d92bd46 

# by transaction hash
/messages/0x830962b211927e61720770bad65a8be0d56263fe33dc77b04229834a462b2f83 
```

# Add new contracts
## add new netowrks and their contracts
1. (optional)update networks rpcs in rails console.  
   `Pug::Network.find_by(chain_id: 1).update rpc: 'https://ethereum.publicnode.com'`

2. update `config/ormpscan2.yml`.  

3. add contracts of the new networks.  
   `ETHERSCAN_API_KEY=#{api_key} rails 'pug:add_contract[#{network.chain_id},#{contract_address}]' --trace`  
   NOTE1: you can manually add the contract. or, you can use helper task `rails contracts:add` to add all msgport and ormp contracts.  
   NOTE2: `pug:add_contract` depends on etherscan(-like) api to get contract creational info.  
   NOTE3: `ETHERSCAN_API_KEY` is optional, but without it, the api is limited to a small requests per second.  

4. update Procfile.pug, then rerun `bin/pug`.  
   `rails pug:procfile`  

## add new contract to an existing network  
1. add the contract to the network.  
