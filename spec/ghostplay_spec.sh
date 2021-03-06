#shellcheck shell=sh

Describe 'ghostplay'
  # shellcheck disable=SC1091
  . ./ghostplay

  ghostplay_before_prompt_hook() { :; }
  ghostplay_after_prompt_hook() { :; }
  ghostplay_before_type_hook() { :; }
  ghostplay_after_type_hook() { :; }
  ghostplay_custom_prompt() { shellspec_puts '$ '; }

  Describe 'ghostplay_sigint_handler()'
    Example 'should exit with 1'
      When invoke ghostplay_sigint_handler
      The status should be failure
    End
  End

  Describe 'ghostplay_exit_handler()'
    ghostplay_cleanup_handler() { echo called ghostplay_cleanup_handler; }
    Example 'calls ghostplay_cleanup_handler'
      When call ghostplay_exit_handler
      The output should equal "called ghostplay_cleanup_handler"
    End
  End

  Describe 'ghostplay_sleep()'
    Example 'calls sleep by default'
      sleep() { echo called sleep "$1"; }
      When call ghostplay_sleep 3
      The output should equal "called sleep 3"
    End

    Example 'calls ghostplay_custom_sleep'
      ghostplay_custom_sleep() { echo called ghostplay_custom_sleep; }
      When call ghostplay_sleep
      The output should equal "called ghostplay_custom_sleep"
    End
  End

  Describe 'ghostplay_puts()'
    Example 'outputs raw text'
      When call ghostplay_puts a b '\n'
      The output should equal 'a b \n'
    End
  End

  Describe 'ghostplay_prompt()'
    ghostplay_custom_prompt() { echo custom prompt; }
    Example 'outputs prompt'
      When call ghostplay_prompt
      The output should equal 'custom prompt'
    End

    Example 'calls ghostplay_before_prompt_hook before prompt'
      ghostplay_before_prompt_hook() { echo before_prompt; }
      When call ghostplay_prompt
      The first line of output should equal 'before_prompt'
      The second line of output should equal 'custom prompt'
    End

    Example 'calls ghostplay_after_prompt_hook after prompt'
      ghostplay_after_prompt_hook() { echo after_prompt; }
      When call ghostplay_prompt
      The first line of output should equal 'custom prompt'
      The second line of output should equal 'after_prompt'
    End
  End

  Describe 'ghostplay_input()'
    Example 'types characters'
      ghostplay_type() { echo "$1"; }
      When call ghostplay_input "ABCDE"
      The line 1 of output should equal 'A'
      The line 2 of output should equal 'B'
      The line 3 of output should equal 'C'
      The line 4 of output should equal 'D'
      The line 5 of output should equal 'E'
      The lines of output should equal 5
    End
  End

  Describe 'ghostplay_type()'
    Example 'outputs string'
      When call ghostplay_type 'abcde'
      The output should equal 'abcde'
    End

    Example 'calls ghostplay_before_type_hook before type'
      ghostplay_before_type_hook() { shellspec_puts "prepend-"; }
      When call ghostplay_type 'abcde'
      The output should equal 'prepend-abcde'
    End

    Example 'calls ghostplay_after_type_hook after type'
      ghostplay_after_type_hook() { shellspec_puts "-append"; }
      When call ghostplay_type 'abcde'
      The output should equal 'abcde-append'
    End
  End

  Describe 'ghostplay_command_and_exec()'
    Example 'outputs command and exec'
      When call ghostplay_command_and_exec "echo 123"
      The first line of output should equal 'echo 123'
      The second line of output should equal '123'
      The third line of output should equal '$ '
    End
  End

  Describe 'ghostplay_command_and_fake()'
    Example 'outputs command and not exec'
      When call ghostplay_command_and_fake "echo 123"
      The first line of output should equal 'echo 123'
      The second line of output should equal '$ '
    End
  End

  Describe 'ghostplay_run()'
    Example 'executes by each line'
      Data
        #|echo 1
        #|echo 2
      End
      When call ghostplay_run
      The line 1 of output should equal '$ echo 1'
      The line 2 of output should equal '1'
      The line 3 of output should equal '$ echo 2'
      The line 4 of output should equal '2'
    End

    Example 'executes with batch'
      Data
        #|#ghostplay batch
        #|echo 1
        #|echo 2
        #|#ghostplay end
      End
      When call ghostplay_run
      The line 1 of output should equal '$ echo 1'
      The line 2 of output should equal 'echo 2'
      The line 3 of output should equal '1'
      The line 4 of output should equal '2'
      The line 5 of output should equal '$ '
    End

    Example 'executes with batch and flush'
      Data
        #|#ghostplay batch
        #|echo 1
        #|#ghostplay flush
        #|echo 2
        #|#ghostplay end
      End
      When call ghostplay_run
      The line 1 of output should equal '$ echo 1'
      The line 2 of output should equal '1'
      The line 3 of output should equal '$ echo 2'
      The line 4 of output should equal '2'
      The line 5 of output should equal '$ '
    End

    Example 'executes with silent'
      Data
        #|#ghostplay silent
        #|echo 1
        #|echo 2
        #|#ghostplay end
      End
      When call ghostplay_run
      The line 1 of output should equal '1'
      The line 2 of output should equal '2'
      The line 3 of output should be blank
    End

    Example 'executes with fake'
      Data
        #|#ghostplay fake
        #|echo 1
        #|echo 2
        #|#ghostplay end
      End
      When call ghostplay_run
      The line 1 of output should equal '$ echo 1'
      The line 2 of output should equal 'echo 2'
      The line 3 of output should equal '$ '
    End

    Example 'executes with sleep'
      sleep() { echo "$@"; }
      Data
        #|#ghostplay sleep 5
      End
      When call ghostplay_run
      The output should equal 5
    End
  End
End
