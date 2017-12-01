#!/bin/bash

# There are some examples in the RC4 article in Wikipedia.
#So, let's check we get the same bytes

# Cipher the example plain texts
echo -n "Plaintext" | ./arcfour tests/Key > tests/plaintext.tmp
echo -n "pedia" | ./arcfour tests/Wiki > tests/pedia.tmp
echo -n "Attack at dawn" | ./arcfour tests/Secret > tests/attack.tmp

# Check cipher texts against expected files
diff tests/plaintext.{tmp,enc} || exit 1
diff tests/pedia.{tmp,enc} || exit 1
diff tests/attack.{tmp,enc} || exit 1
