#!/bin/sh

echo "[STEP 1]: first run two built-in shells"
./make-debug.sh
./copy.sh
echo "[STEP 2]: and reboot"
ssh -i ~/.ssh/id_host Archive@192.168.56.3 "shutdown -r -t 0"
echo "[STEP 3]: wait for 30 sec"
sleep 30
echo "[STEP 4]: then copy exe and dll to the remote host"
scp -i ~/.ssh/id_host ~/.cuckoo/monitor/$(cat ~/.cuckoo/monitor/latest)/* Archive@192.168.56.3:/cygdrive/c/tmp3wnweh/bin
echo "[STEP 5]: delete log files"
ssh -i ~/.ssh/id_host Archive@192.168.56.3 "cd /cygdrive/c && rm *.txt *.log"
echo "[STEP 6]: change debug param in conf"
ssh -i ~/.ssh/id_host Archive@192.168.56.3 "cd /cygdrive/c/tmp3wnweh && ./update-debug.sh 1"
echo "[STEP 7]: execute analyzer.py"
ssh -i ~/.ssh/id_host Archive@192.168.56.3 "cd /cygdrive/c/tmp3wnweh && export TEMP=/tmp && cmd /C 'python analyzer.py'" &
echo "[STEP 8]: wait for 5 sec to let program run to the debugger"
sleep 5
