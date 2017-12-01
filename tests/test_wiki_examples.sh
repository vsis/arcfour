#!/bin/bash

echo -n "Plaintext" | ./arcfour tests/Key > tests/plaintext.tmp
echo -n "pedia" | ./arcfour tests/Wiki > tests/pedia.tmp
echo -n "Attack at dawn" | ./arcfour tests/Secret > tests/attack.tmp
diff tests/plaintext.{tmp,enc} || exit 1
diff tests/pedia.{tmp,enc} || exit 1
diff tests/attack.{tmp,enc} || exit 1
