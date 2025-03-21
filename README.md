# solana-validator-tools
fork from https://github.com/Block-Logic/solana-validator-tools

Here are some of the tools that I use for Solana validator log analysis. Most of the script are written in Ruby and any recent version of Ruby on your system should work.

`process_log_slot_timing.rb` is a script that will process a validator or RPC log file and write slot timings to a CSV file.

To try the script, run  `ruby process_log_slot_timing.rb solana.log` to write a CSV file. I have also included `logs_20220601.1hour.xls` for the instant gratification crowd.

---
<details>
<summary>Ruby setup</summary>

```bash
apt update && apt install ruby -y
```

</details>

```bash
cd
git clone https://github.com/Hohlas/solana-validator-tools.git --recurse-submodules validator_tools
cd validator_tools
cp ~/solana/solana.log ~/validator_tools/solana.log
ruby process_log_slot_timing.rb solana.log
```
