# Software
 - [VSCode](https://code.visualstudio.com/docs/?dv=win) 
 - [Windows Terminal](https://apps.microsoft.com/store/detail/windows-terminal/9N0DX20HK701?hl=en-gb&gl=gb)

## Windows Terminal Configuration
Let's make Windows Terminal look and feel like a Mac Terminal.

## Install Ubuntu on Windows with WSL
```
wsl --install -d ubuntu
```

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

```
sudo apt update && sudo apt install zsh -y
```

## Install OhMyZsh
```
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

## Generate SSH Key
This is needed to run `git clone` and `git push` using SSH.

### Generate a SSH Key
```
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```
Hit enter for the next 3 questions.

### List the Keys
```
ls -al ~/.ssh
```

Before adding a new SSH key to the ssh-agent to manage your keys, you should have checked for existing SSH keys and generated a new SSH key.

### Start the ssh-agent in the background.
```
eval "$(ssh-agent -s)"

```

### Add your SSH private key to the ssh-agent.
```
ssh-add ~/.ssh/id_ed25519
```

## Adding SSH Key To GitHub
```
cat ~/.ssh/id_ed25519.pub
```

Copy and paste that and add it to GitHub [here](https://github.com/settings/keys) after clicking `New SSH key`.

## Install PIP
This will allow you to downoad Python packages with `pip install`.

```
sudo apt install python-pip
```


# Access Files From Windows
You can access the Linux system from `\\wsl$` within Windows.

Create a new folder called code in your Windows user file. In this example I will create a folder called code in `C:\Users\username\code`

From your terminal access that folder:
```
cd /mnt/c/Users/username/code/
```

# Clone Git Repo

`git clone` will clone the repo locally. Now you can create a branch and push your changes.
```
git clone git@github.com:Cemito/windows-ps.git
```