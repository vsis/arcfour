#!/bin/bash

# We try to cipher and decipher saber1 examples

echo -n "nullprogram" > tests/saber1.key.tmp

# Cipher
./saber1 cipher tests/saber1.key.tmp < tests/ciphersaber.png > tests/ciphersaber.png.enc.tmp || exit 1

# Decipher example
./saber1 decipher tests/saber1.key.tmp < tests/ciphersaber.png.cs > tests/ciphersaber.png.tmp || exit 1

# Decipher our file
./saber1 decipher tests/saber1.key.tmp < tests/ciphersaber.png.enc.tmp > tests/ciphersaber_our.png.tmp || exit 1

# Now check if there are differences with example files
diff tests/ciphersaber.png tests/ciphersaber.png.tmp || exit 1
diff tests/ciphersaber.png tests/ciphersaber_our.png.tmp || exit 1
