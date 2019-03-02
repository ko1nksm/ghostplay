#!/bin/sh

: 1. Write your script

# ghostplay batch
cat << DATA > your.script.sh
echo This is your script.
echo ghostplay types your script and execute.
DATA
# ghostplay end

: 2. Execute by ghostplay

./ghostplay your.script.sh

# ghostplay silent
rm your.script.sh
# ghostplay end
