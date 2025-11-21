# 🛠️ Contributing to `git-synchronize` #

## 🔧 Development Setup ##

This environment setup for **Arch Linux**.

### 📦 Install Dependencies ###

Install required dependencies for development and testing this script:

```bash
sudo pacman -S --noconfirm \
    git \
    make \
    bash \
    parallel \
    bats \
    docker \
    docker-compose \
    bats \
    shfmt \
    shellcheck \
    bats \
    bats-assert \
    bats-support \
    bats-file \
    pre-commit
```

Install [bats-alimektor](https://github.com/Alimektor/bats-alimektor) library for testing.

### 🔒 Use `pre-commit` ###

Use [pre-commit](https://pre-commit.com/) to check your code before commiting:

```bash
pre-commit install
```

### 🎯 Run Tests ###

Run tests using [Bats](https://github.com/bats-core/bats-core) and [Docker Compose](https://github.com/docker/compose):

```bash
make test
```

## 🦄 Create a Pull Request ##

You can create a pull request to the [git-synchronize](https://github.com/Alimektor/git-synchronize) repository on GitHub.

## 📝 Contribution Guidelines ##

- 📝 Code style: Follow the existing code style and conventions.
- 🔍 Testing: Ensure all tests pass before submitting a PR.
- 📄 Documentation: Update documentation as needed.
- 🎯 Feature requests: Open an issue before starting work on a new feature.

## 🤝 Community Guidelines ##

- 🤝 Respect: Be respectful to all contributors.
- 👥 Collaboration: Work together to improve the project.
- 🔄 Feedback: Provide constructive feedback.
