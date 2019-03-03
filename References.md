# References

## Directives

```
#ghostplay <directive> [<parameters>...]
```

### batch

Normally, ghostplay execute statement by one line.
If you want to execute multiline statement at once, use `batch` directive.
Execute at once, from `batch` directive to `end` directive.

### flush

Use it inside of `batch` directive to `end` directive,
execute the statements so far.

### silent

Execute the statements from `silent` directive to `end` directive,
but not typing (not showing on screen).

### fake

Types the statements from `fake` directive to `end` directive,
but not execute.

### end

End of `batch` directive, `silent` directive, and `fake` directive.

### sleep `<seconds>`

Sleep specified seconds.

## Custom Functions

If you want to change default behavior, (re)define the function.

###ghostplay_custom_prompt

If you want to change prompt, redefine the `ghostplay_custom_prompt` function.

Example (Simple $ only prompt)

```sh
ghostplay_custom_prompt() {
  printf '$ '
}
```

###ghostplay_custom_sleep

ghostplay use `sleep` command to sleep. `sleep` command assume to can use fractional value. If you are using `sleep` command that can not use fractional values, you will need to redefine `ghostplay_custom_sleep` function.

Example (Using perl)

```sh
ghostplay_custom_sleep() {
  perl -MTime::HiRes=sleep -e "sleep($1)"
}
```

## Handlers

###ghostplay_cleanup_handler

Called after end of script (include Ctrl+C). You can write cleanup code.

## Hooks

###ghostplay_before_prompt_hook

Called before the prompt is displayed. (Default: none)

###ghostplay_after_prompt_hook

Called after the prompt is displayed. (Default: ```ghostplay_sleep 0.5```)

###ghostplay_before_type_hook

Called before type one character. (Default: ```ghostplay_sleep 0.02```)

###ghostplay_after_type_hook

Called after type one character. (Default: none)

## Variables

You can use those variables in your script.

| Name        | Value               |
| ----------- | ------------------- |
| GP_USERNAME | User name           |
| GP_HOSTNAME | Host name           |
| GP_SOURCE   | File name of script |
| GP_LF       | New line (0x0A)     |
| GP_ESC      | Escape code (0x1B)  |
