#!/bin/bash
# try different password permutations to decrypt a luks 
# encrypted volume. 
# this originated from this so post
#
# https://unix.stackexchange.com/questions/495833/automate-multiple-password-enties-to-decrypted-luks-ext4-usb-stick

# make sure right # of params
if [ $# -lt 2 ]; then
    echo "usage: ./decrypt-luks.sh [list] [disk]"
    exit 1
fi

# handle spaces in passphrases
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

# assign vars
LIST=${1}
DISK=${2}

# try the passphrases. break on success. 
# note that this could be much faster if multithreaded. 
# the easiest way to do this is to split the list into 
# `n` chunks and then run four parallel processes (either 
# in different shells or by using the `&`.)
for pw in $(cat ${LIST})
do 
    echo -n "${pw}" | cryptsetup open ${DISK} luks \
        && echo "${pw} is the passphrase" \
        && break
done

# restore ifs
IFS=$SAVEIFS

