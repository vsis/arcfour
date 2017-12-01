#!/bin/bash

# We should be capable to use a random 256 Bytes key

# Get a random key
head -c 256 < /dev/random > tests/rkey

# Get a random file
head -c 2048 < /dev/random > tests/2048.tmp

# Cipher and decipher it, with our random key
./arcfour tests/rkey < tests/2048.tmp | ./arcfour tests/rkey > tests/2048.tmp.diff

# Check difference
diff tests/2048.tmp tests/2048.tmp.diff || exit 1

