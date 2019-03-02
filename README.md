# ghostplay

ghostplay is an automatic terminal input tool.

## Demo

### 1. Write your script

[example/script.sh]

```sh
#!/bin/sh
echo This is your script.
echo ghostplay types your script and execute.
```

### 2. Execute by ghostplay

```sh
ghostplay example/script.sh
```

See what happens in your terminal. ghost is typing your script!

![demo](demo.gif)

Another example scripts is in the [example](/example) directory.

## Cooperation with terminal session recorder

### asciinema

```sh
# Record terminal session
asciinema rec -c "ghostplay example/script.sh"
```

### ttyrec & seq2gif

```sh
# Record terminal session to a file "ttyrecord'
ttyrec -e "ghostplay example/script.sh"

# Convert to animated gif
seq2gif -i ttyrecord -o demo.gif
```
