#!/bin/bash

# If we create a random file, then cipher and decipher it, we should get the same file

# Get a random key
head -c 128 < /dev/urandom > tests/saber1.key.tmp

# Get a random file
head -c 4096 < /dev/urandom > tests/saber1.file.tmp

# Cipher and decipher
./saber1 cipher tests/saber1.key.tmp < tests/saber1.file.tmp | ./saber1 decipher tests/saber1.key.tmp > tests/saber1.file.tmp.diff

# Check differences
diff tests/saber1.file.tmp tests/saber1.file.tmp.diff || exit 1
