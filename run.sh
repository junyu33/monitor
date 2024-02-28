#!/bin/sh

echo "[STEP 1]: first run two built-in shells"
./make-debug.sh
./copy.sh
echo "[STEP 2]: then copy exe and dll to the remote host"
ssh -i ~/.ssh/id_host junyu33@192.168.18.1 "scp -r 192.168.18.128:~/.cuckoo/monitor ~/.cuckoo"
echo "[STEP 3]: and submit files"
ssh -i ~/.ssh/id_host junyu33@192.168.18.1 "source ~/.zshrc && conda activate python2 && cuckoo submit --memory /run/media/junyu33/develop/tmp1/scu/research/2024/VirusShare0/662/VirusShare_0aa06ef1402d832b789698f0b53f54a1"

