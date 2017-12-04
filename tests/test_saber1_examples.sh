#!/bin/bash

# We try to cipher and decipher saber1 examples

echo -n "nullprogram" > tests/saber1.key.tmp
echo -n "ThomasJefferson" > tests/saber1.key2.tmp

# Cipher
./saber1 cipher tests/saber1.key.tmp < tests/ciphersaber.png > tests/ciphersaber.png.enc.tmp || exit 1
./saber1 cipher tests/saber1.key2.tmp < tests/cknight.gif > tests/cknight.enc.diff || exit

# Decipher examples
./saber1 decipher tests/saber1.key.tmp < tests/ciphersaber.png.cs > tests/ciphersaber.png.tmp || exit 1
./saber1 decipher tests/saber1.key2.tmp < tests/cknight.cs1 > tests/cknight.gif.tmp || exit 1

# Decipher our files
./saber1 decipher tests/saber1.key.tmp < tests/ciphersaber.png.enc.tmp > tests/ciphersaber_our.png.tmp || exit 1
./saber1 decipher tests/saber1.key2.tmp < tests/cknight.enc.diff > tests/cknight.gif_our.tmp || exit 1

# Now check if there are differences with example files
diff tests/ciphersaber.png tests/ciphersaber.png.tmp || exit 1
diff tests/ciphersaber.png tests/ciphersaber_our.png.tmp || exit 1
diff tests/cknight.gif.tmp tests/cknight.gif || exit 1
diff tests/cknight.gif_our.tmp tests/cknight.gif || exit 1
