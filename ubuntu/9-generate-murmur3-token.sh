#!/usr/bin/bash
# ./generate-murmur3-token.sh 16

number_of_tokens=$1
echo $(python -c "print [str(((2**64 / $number_of_tokens ) * i) - 2**63) for i in range($number_of_tokens)]")
