#!/bin/sh

: Usage ghostplay example/script.sh
echo This is ghostplay example

# ghostplay silent
echo silent
# ghostplay end

# ghostplay batch
cat<<DATA
multi line test
multi line test
multi line test
DATA
# ghostplay end
