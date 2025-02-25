# Git Synchronize #

![ci](https://github.com/Alimektor/git-synchronize/actions/workflows/ci.yml/badge.svg)

`git-synchronize` is a Git command that helps you synchronize your local git repository with a remote repository with automatic commit message and push.

## Installation ##

Clone the repository:

```bash
git clone https://github.com/Alimektor/git-synchronize.git
cd git-synchronize
```

Install for system usage:

```bash
make install
```

Install for user usage:

```bash
make install LOCAL=true
```

## Usage ##

Go to your local git repository and run the following command:

```bash
git synchronize
```

Enjoy!

For more options and examples, see [the documentation](/docs/docs.md)

## License ##

For details, see [LICENSE](/LICENSE.md)
