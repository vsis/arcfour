#!/bin/bash

head -c 256 < /dev/random > tests/rkey
head -c 2048 < /dev/random > tests/2048.tmp
./arcfour tests/rkey < tests/2048.tmp | ./arcfour tests/rkey > tests/2048.tmp.diff
diff tests/2048.tmp tests/2048.tmp.diff || exit 1

