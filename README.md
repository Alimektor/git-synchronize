# 🔄 Git Synchronize 🔄 #

![ci](https://github.com/Alimektor/git-synchronize/actions/workflows/ci.yml/badge.svg)

> Your Ultimate Git Sync Companion

📄🚀 `git-synchronize` is a powerful Git command that helps you effortlessly synchronize your local Git repository with a remote repository, complete with automatic commit message and seamless pushes.

## 🛠 Installation ##

### Option 1: [curl](https://curl.se/) ###

Install using `curl` for user usage without man page support:

```bash
curl -fsSL https://raw.githubusercontent.com/Alimektor/git-synchronize/main/install.sh | bash
```

### Option 2: [Make](https://www.gnu.org/software/make) ###

📥 Clone the repository:

```bash
git clone https://github.com/Alimektor/git-synchronize.git
cd git-synchronize
```

#### System-Wide Installation ####

```bash
make install
```

#### Install for user usage ####

```bash
make install LOCAL=true
```

## 🚀 Usage ##

Navigate to your local Git repository and run the following command:

```bash
git synchronize
```

🎉 Enjoy the magic!

## 📚 Documentation ##

For more options and examples, see [📘 the documentation](/docs/docs.md)

## 🤝 Contributing ##

See [CONTRIBUTING](/CONTRIBUTING.md).

## 📜 License ##

For details, see [LICENSE](/LICENSE.md).
