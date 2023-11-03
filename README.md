# README

```bash
# LIST
/messages?status=accepted # all, status is an optional filter, same for all other lists
/messages/crab # all from crab
/messages/_/crab # all to crab
/messages/arb_sep/crab # all from arb_sep to crab

# SINGLE MESSAGE
/messages/crab/arb_sep/1 # the index 1 message from arb_sep to crab
/messages/0x139501988f5142b5f12d9df60e75df625a4a0476c273b4539a1770185d92bd46 # by msg hash
/messages/0x830962b211927e61720770bad65a8be0d56263fe33dc77b04229834a462b2f83 # by transaction hash
```
