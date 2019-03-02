#!/bin/sh

: Usage ghostplay example/script.sh
echo This is ghostplay example

# ghostplay silent
echo silent
# ghostplay end

# ghostplay batch
cat<<DATA
multi line test 1
multi line test 2
multi line test 3
DATA
# ghostplay flush
echo flush at before this line
# ghostplay end


# ghostplay fake
echo fake
# ghostplay end
