# INSTALL ALL THE APPS FOR DRG 
#

# INSTALL BOXSTARTER AND CHOCOLATEY
$SourcePath = \\server\it\scripts\INSTALL\PRODUCTION
#Set-ExecutionPolicy Unrestricted - don't do this
#. { iwr -useb https://boxstarter.org/bootstrapper.ps1 } | iex; get-boxstarter -Force

iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
#$SourcePath\BOXSTARTER\Boxstarter.2.12.0\setup.bat

#Set some things and install some things
Set-TimeZone -Name "Mountain Standard Time" -Verbose
choco install  microsoft-edge, googlechrome, adobereader, unifying, microsoft-teams.install -y
# Turn off UAC
Disable-UAC

# Set Windows expolorer options
Set-TaskbarOptions -Size Small -Dock Bottom -Combine Full -Lock
Set-TaskbarOptions -Size Small -Dock Bottom -Combine Full -AlwaysShowIconsOn
Set-ExplorerOptions -showFileExtensions
Enable-PSRemoting -Force

#Install Splashtop
msiexec /norestart /qn /i $SourcePath\SPLASHTOP\SplashTop_Streamer_Win.msi USERINFO="dcode=RHYXJ7A7RPLZ,hidewindow=1,confirm_d=0"

#copy CERM setup bits to local machine
$install_path = "C:\SCRIPTS\INSTALL\CERM"
If(!(test-path $install_path))
{
      New-Item -ItemType Directory -Force -Path $install_path
}

# Download most recent CERM.MSI from the server
$url = "http://x.x.x.x/CermBoXX/CERM-CLIENT/cerm.msi"
$output = "C:\scripts\install\CERM\cerm.msi"

Invoke-WebRequest $url -outfile $output

msiexec /i C:\scripts\install\cerm\cerm.msi /passive /qb /norestart /log C:\scripts\install\CERM\cerminstall.log
$path = "C:\ProgramData\Cerm\Database"
If(!(test-path $path))
{
      New-Item -ItemType Directory -Force -Path $path
      Copy-Item $SourcePath\CERM\CermConnectionDefs.ini "C:\ProgramData\Cerm\Database"
}

# ADD CERM SERVERS TO HOSTS FILE
$file = "$env:windir\System32\drivers\etc\hosts"
"x.x.x.x CERM-ENGINE" | Add-Content -PassThru $file
"x.x.x.x CERM-DATA" | Add-Content -PassThru $file


#Update the workstation

Update-Help
Install-WindowsUpdate | Out-Null # Waits for Windows Update to finish before rebooting. 

Restart-Computer -Force