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

## Add new network and contract
* Add a network.
   ```ruby
   chain_id = 46
   name = 'darwinia'
   display_name = 'Darwinia Network'
   rpc = 'https://rpc.darwinia.network'
   explorer = 'https://darwinia.subscan.io'
   Pug::Network.create(chain_id:, name:, display_name:, rpc:, explorer:, scan_span: 2000)
   ```

* Add a contract.  
   ```bash
   ETHERSCAN_API_KEY=#{api_key} bin/rails 'pug:add_contract[#{network.chain_id},#{contract_address}]' --trace
   ```
   NOTE: `pug:add_contract` depends on etherscan(-like) api to get contract creational info.  

* Update `Procfile.pug` if a new network was added.
   ```bash
   bin/rails pug:procfile
   ```

## Start tracing

```bash
bin/pug
bin/rails messages:trace
```
