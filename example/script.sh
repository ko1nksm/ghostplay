#!/bin/sh

echo This is ghost play example

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
