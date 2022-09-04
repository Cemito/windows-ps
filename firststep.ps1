param($username, $fullName)

#### Enable This PC on Desktop
#HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel\ {20D04FE0-3AEA-1069-A2D8-08002B30309D} = 0/show , 1/hide
$path="HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel"
$name="{20D04FE0-3AEA-1069-A2D8-08002B30309D}"
$exist="Get-ItemProperty -Path $path -Name $name"

if ($exist) {
    Set-ItemProperty -Path $path -Name $name -Value 0 -Force
}
Else {
    New-ItemProperty -Path $path -Name $name -Value 0 -Force
}

#### Installs Chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

#Change here the packages you want to install
$Packages = @("firefox", "vscode")

function Install-ChocoPackage {

    [cmdletbinding()]
    param(
        [String]$PackageName
    )

    $ChocoLibPath = "C:\ProgramData\chocolatey\lib"

    if (-not(test-path $ChocoLibPath)){
        Set-ExecutionPolicy Bypass -Scope Process -Force;
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072;
        iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    }

    #Test if the package folder exists on Choco Lib folder
    if (!((test-path "$ChocoLibPath\$PackageName"))) {

        Write-Host "[INFO]Installing $PackageName..." -ForegroundColor Yellow
        $start_time = Get-Date
        #Install the package without confirmation prompt
        choco install -y -v $PackageName
        Write-Host "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"

    }
    else {
        Write-host  "[INFO]$PackageName is already installed." -ForegroundColor Green
    }
}

#Loop through each package to install them
foreach($Package in $Packages) {
    Install-ChocoPackage -PackageName $Package
}

#### Remove Windows Bloatware
Get-AppxPackage *3dbuilder* | Remove-AppxPackage
Get-AppxPackage *xboxapp* | Remove-AppxPackage
Get-AppxPackage *officehub* | Remove-AppxPackage
Get-AppxPackage *getstarted* | Remove-AppxPackage

#### Rename Computer

if ( $env:COMPUTERNAME -match "EC2AMAZ" ) {
    Write-Output "Computer name already setup as $env:COMPUTERNAME so not renaming computer."
}
else {
    Write-Output "Setting computer name to 3VB-$cmdSerialNumber."
    $cmdSerialNumber = (Get-WmiObject -class win32_bios).SerialNumber
    $computer = "3VB-$SerialNumber"
    #Rename-Computer -NewName $computer -Force
}

#### New local admin user
try {
    $cmdSerialNumber = (Get-WmiObject -class win32_bios).SerialNumber
    $Password = "3VB-$SerialNumber"
    $securePassword = ConvertTo-SecureString $Password -AsPlainText -Force
    New-LocalUser $username -Password $securePassword -FullName $fullName -Description $fullName -AccountNeverExpires -PasswordNeverExpires -ErrorAction Stop
}
catch {
    $message = $_
    Write-Warning "$message"
}
$Admins = Get-LocalGroupMember -Name Administrators | Select-Object -ExpandProperty name
if ( $Admins -match $Username ) {
    "$Username is a local administrator"
}
else {
    "$Username is NOT a local administrator"
    "Adding as local administrator"
    Add-LocalGroupMember -Group "Administrators" -Member $Username -ErrorAction Stop
}
