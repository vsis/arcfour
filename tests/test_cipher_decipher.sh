#!/bin/bash

head -c 256 < /dev/random > tests/256.tmp
head -c 2048 < /dev/random > tests/2048.tmp
./arcfour tests/Key < tests/256.tmp | ./arcfour tests/Key > tests/256.tmp.diff
./arcfour tests/Key < tests/2048.tmp | ./arcfour tests/Key > tests/2048.tmp.diff
diff tests/256.tmp tests/256.tmp.diff || exit 1
diff tests/2048.tmp tests/2048.tmp.diff || exit 1
