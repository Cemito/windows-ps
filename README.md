# Windows Powershell Script
This script will help with setting up new laptops automating the manual steps required.
- This script will enable My Computer on the desktop.
- Use [Chocolatey](https://community.chocolatey.org/) to download and install packages of your choosing. 
Currently, installs Firefox and VSCode. Bloatware programs such as Xbox, Get Office, Get started will also be removed.
- Automatically renames the computer.
- Creates a local user with user input and auto sets the user password.

## Usage
Search for Windows PowerShell. Right click Run as administrator. 
Run the following command with the two parameters passed in:

- `username` - The local admin username
- `fullName` - Full users name also to be used as the description

```
path\to\script\location\firststep.ps1 -username "jdoe" -fullName "Jane Doe"
```

## Testing
Tested on Windows Server 2016 and working as expected. The uninstall Windows bloatware programs is untested as
it doesn't come on Windows Server.

## References
- [Installing Tools Using Powershell and Chocolatey (Windows)](
https://rafaelmedeiros94.medium.com/installing-tools-using-powershell-and-chocolatey-windows-60d02ff7a7b9)

- [Uninstall MS Programs Bloatware](https://www.onmsft.com/how-to/uninstall-your-programs-using-powershell) - Uninstall
Xbox, Get Office, Get Started, 3D Builder.
