# Getting Started
This will README will help with setting up useful tools and configrations on Windows to give you the Mac/Linux experience.

## Prerequisites
 - [VSCode](https://code.visualstudio.com/docs/?dv=win) used as an IDE to edit code.
 - [Windows Terminal](https://apps.microsoft.com/store/detail/windows-terminal/9N0DX20HK701?hl=en-gb&gl=gb) a more powerful terminal.

## Install Ubuntu on Windows with WSL
Launch Windows Terminal and run the following commands to install Ubuntu.
```ps
wsl --list --online
wsl --install Ubuntu-20.04
```

# Windows Terminal Configuration
Let's make Windows Terminal look and feel like a Mac Terminal.

## Setting up WSL as the default profile
When you run the Windows Terminal, you can see that the Terminal opens the Windows PowerShell by default. Since I am going to be using WSL all the time, I want this to be the default.

We can change the default profile by opening the terminal menu (press the down arrow) and select settings.

Open settings from the terminal menu
- Scroll down to find the `guid` for the WSL
- Copy that `guid` and scroll back up
- Paste the WSL `guid` inside the `defaultProfile` setting

## Install and Setup ZSH and Oh-My-Zsh
Slimmed down version of steps from https://theflying.dev/digital-garden/setting-up-windows-terminal/

## Install ZSH
The Z shell (also known as zsh ) is a Unix shell that is built on top of bash (the default shell for macOS) with additional features. It's recommended to use zsh over bash . It's also highly recommended to install a framework with zsh as it makes dealing with configuration, plugins and themes a lot nicer.

```sh
sudo apt update && sudo apt install zsh -y
```

## Install OhMyZsh
Oh My Zsh will not make you a 10x developer...but you may feel like one.

```sh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

# Git
## Installing Git on Ubuntu
To install Git run the following command:
```sh
sudo apt install git
```

## Generate SSH Key
This is needed to run `git clone` and `git push` using SSH.

### Generate a SSH Key
```sh
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```
Hit enter for the next 3 questions.

### List the Keys
```sh
ls -al ~/.ssh
```

Before adding a new SSH key to the ssh-agent to manage your keys, you should have checked for existing SSH keys and generated a new SSH key.

### Start the ssh-agent in the background.
```sh
eval "$(ssh-agent -s)"
```

### Add your SSH private key to the ssh-agent.
```sh
ssh-add ~/.ssh/id_ed25519
```

## Adding SSH Key To GitHub
```sh
cat ~/.ssh/id_ed25519.pub
```

Copy and paste that and add it to GitHub [here](https://github.com/settings/keys) after clicking `New SSH key`.

## Install PIP
This will allow you to downoad Python packages with `pip install`.

```sh
sudo apt install python-pip
```


# Access Files From Windows
You can access the Linux system from `\\wsl$` within Windows.

Create a new folder called code in your Windows user file. In this example I will create a folder called code in `C:\Users\username\code`

From your terminal access that folder:
```sh
cd /mnt/c/Users/username/code/
```

## Create a Symlink
So you do not have to remember the full path directory name every time. Create a Symlink in your home directory.

```sh
cd ~
ln -s /mnt/c/Users/username/code/ .
```

You can now easily change to that directory with `cd code`.

# Clone Git Repo

`git clone` will clone the repo locally. Now you can create a branch and push your changes.
```sh
git clone git@github.com:Cemito/windows-ps.git
```