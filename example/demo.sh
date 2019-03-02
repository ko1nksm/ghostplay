#!/bin/sh

# ghostplay silent
ghostplay_cleanup() {
  if [ -f your.script.sh ]; then
    rm your.script.sh
  fi
}
# ghostplay end

: 1. Write your script

# ghostplay batch
cat << DATA > your.script.sh
echo This is your script.
echo ghostplay types your script and execute.
DATA
# ghostplay end

: 2. Execute by ghostplay

./ghostplay your.script.sh
