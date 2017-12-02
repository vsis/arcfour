#!/bin/bash

# This cipher is suposed to handle big files. Not simply test files.

# Generate files of 1 MB, 10 MB and 50 MB
head -c 1048576 < /dev/urandom > tests/1MB.tmp
head -c 10485760 < /dev/urandom > tests/10MB.tmp
head -c 52428800 < /dev/urandom > tests/50MB.tmp

# Generate a 256 key
head -c 256 < /dev/urandom > tests/key.tmp

# Cipher and decipher
./arcfour tests/key.tmp < tests/1MB.tmp | ./arcfour tests/key.tmp > tests/1MB.tmp.diff
./arcfour tests/key.tmp < tests/10MB.tmp | ./arcfour tests/key.tmp > tests/10MB.tmp.diff
./arcfour tests/key.tmp < tests/50MB.tmp | ./arcfour tests/key.tmp > tests/50MB.tmp.diff

# Check difference
diff tests/1MB.tmp tests/1MB.tmp.diff || exit 1
diff tests/10MB.tmp tests/10MB.tmp.diff || exit 1
diff tests/50MB.tmp tests/50MB.tmp.diff || exit 1

# These are big files. So remove them.
rm -r tests/*MB.tmp*
