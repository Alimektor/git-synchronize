% git-synchronize(1) Version 1.0.0 | git-synchronize documentation

`git-synchronize`
=================

**git-synchronize** — is a Git command that helps you synchronize your local git repository with a remote repository with automatic commit message and push

SYNOPSIS
========

`git-synchronize`

`git-synchronize [-m|--message message] [-b|--branch branch]`

`git-synchronize [-h|--help|-v|--version]`

DESCRIPTION
===========

Just run `git synchronize` in your local git repository. You can change the commit message with `-m` and the push remote branch with `-b`. Also you can use .git-synchronize to set default values for these options.

OPTIONS
=======

-h, --help

:   Print this help message.

-v, --version

:   Print utility version.

-m, --message

:   Commit message. Default: "Automatic update".

-b, --branch

:   Branch name. Default: "main".

FILES
=====

*~/.git-synchronize* <OR> **GIT_REPO_DIRECTORY/.git-synchronize**

:   Configuration for git-synchronize. Example file:

    ```bash
    $ cat ~/.git-synchronize
    message=Message from configuration file
    branch=configuration-test
    ```

BUGS
====

See GitHub Issues: <https://github.com/Alimektor/git-synchronize/issues>

EXAMPLE
=======

```bash
$ git init --initial-branch=main
$ git synchronize
$ git log -1 --pretty=%B
Automatic update
```

AUTHORS
=======

Alimektor <alimektor@gmail.com>
