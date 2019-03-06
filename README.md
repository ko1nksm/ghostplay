# ghostplay

ghostplay is an automatic terminal input tool.

Intended to create terminal demo that can easily modified for documentation.
(not for live presentations)

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

See what happens in your terminal. Ghost is typing your script!

![demo](demo.gif)

Another example scripts is in the [example](/example) directory.

## Installation

**Just get the ghostplay and create a symlink in your PATH!**

For example

```sh
$ git clone https://github.com/ko1nksm/ghostplay.git
$ ln -s $PWD/ghostplay/ghostplay /EXECUTABLE/PATH/
# (e.g. /EXECUTABLE/PATH/ = /usr/local/bin/, $HOME/bin/)
```

## Cooperation with terminal recorder

To create terminal demo, you can use `asciinema`, `ttyrec` or
favorite terminal recorder.

### asciinema

```sh
# Record terminal
asciinema rec -c "ghostplay example/script.sh"
```

### ttyrec & seq2gif

```sh
# Record terminal to a file "ttyrecord'
ttyrec -e "ghostplay example/script.sh"

# Convert to animated gif
seq2gif -i ttyrecord -o demo.gif
```

## Advanced usage

You can customize ghostplay's behavior by [directives](References.md#directives), [custom functions](References.md#custom-functions), [handlers](References.md#handlers), and [hooks](References.md#hooks).

See [References](References.md)

Example

```sh
#!/bin/sh

#ghostplay silent
ghostplay_custom_prompt() { # change prompt
  printf '$ '
}
#ghostplay end

echo This is your script.
echo ghostplay types your script and execute.

#ghostplay sleep 3

#ghostplay batch
cat<<DATA
line1
line2
line3
DATA
#ghostplay end
```
