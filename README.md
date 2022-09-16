# luks-brute

runs through a list of passphrases in an attempt to unlock a luks volume. this is slow, but it would be simple to multithread. really for any heavy lifting, the john the ripper luks module is a much better approach!

## usage

    ./decrypt-luks.sh [word-list] [disk]

For example:

    ./decrypt-luks.sh ~/Documents/wordlist.txt /dev/sdc1

The word list should have one passphrase per line with each line terminated by a newline.