---
title: rbenv installing gems fails with permission error
date: 2015-04-14 23:08 UTC
tags: rbenv, ruby, osx
---

Helping a new dev setup their machine today with `rbenv` when trying to
`bundle` I ran into this error:

```bash
ERROR:  While executing gem ... (Gem::FilePermissionError)
You don't have write permissions for the /Library/Ruby/Gems/2.0.0 directory.
```

Thankfully I already dealt with this before and referenced it as a comment to
a question on StackOverflow. For my own future reference I will list the solution
here as well.


**You need to correct your paths**

To determine if this fix will work run the following:

    which gem

This should output a directory you do not have permissions to:

    /usr/bin/gem

**To fix this perform the following steps.**

 1. Determine the path you need to copy to your profile:
    ```
    rbenv init -
    ```

    The first line of the output is the line you need to copy over to your profile:

    ```bash
      export PATH="/Users/justin/.rbenv/shims:${PATH}" #path that needs to be copied
      source "/usr/local/Cellar/rbenv/0.4.0/libexec/../completions/rbenv.zsh"
      rbenv rehash 2>/dev/null
      rbenv() {
        typeset command
        command="$1"
        if [ "$#" -gt 0 ]; then
          shift
        fi

        case "$command" in
        rehash|shell)
          eval `rbenv "sh-$command" "$@"`;;
        *)
          command rbenv "$command" "$@";;
        esac
      }
    ```

 2. Copy the path to your profile and save it
 3. Reload your profile (source ~/.zshenv for me)
 4. Run `rbenv rehash`

Now when you run `which gem` you should get a local path that you have permissions to:

```
/Users/justin/.rbenv/shims/gem
```
