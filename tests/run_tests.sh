#!/bin/bash

for file in tests/test_*.sh
do
    echo -n "Running: ${file}:   "
    bash $file;
    if [ "$?" = "0" ]
    then
        echo "[ OK ]"
    else
        echo "[FAIL]"
    fi
done
