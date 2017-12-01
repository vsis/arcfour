#!/bin/bash

# We shouldn't be able to decipher a file with a different key.

# Get two 256 Bytes keys
head -c 256 < /dev/random > tests/key0.tmp
head -c 256 < /dev/random > tests/key1.tmp


# Get a test file
head -c 4096 < /dev/random > tests/test.tmp

# Cipher it
./arcfour tests/key0.tmp < tests/test.tmp | ./arcfour tests/key1.tmp > tests/test.tmp.diff

# These should be different files
diff tests/test.tmp tests/test.tmp.diff > /dev/null

if [ "$?" = "0" ]
then
    exit 1
fi
