#######
## Post-install script for a windows desktop
########################################################################
# usage:
#     @powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString('https://raw.github.com/tcurvelo/postinstall.sh/master/windows/desktop.ps1'))"


$downloader = new-object System.Net.WebClient


## Install chocolatey
########################################################################
iex $downloader.DownloadString("https://chocolatey.org/install.ps1")
$env:Path += ";%ALLUSERSPROFILE%\chocolatey\bin"


## Install packages from chocolatey gallery
########################################################################

iex @"
choco install avastfreeantivirus
choco install calibre
choco install ccleaner
choco install cdburnerxp
choco install dropbox
choco install evernote5
choco install Firefox
choco install gimp
choco install GoogleChrome
choco install InkScape
choco install handbrake
choco install launchy
choco install libreoffice
choco install skype
choco install steam
choco install SublimeText3
choco install utorrent
choco install vagrant
choco install virtualbox
choco install vlc
"@

## Install cygwin
########################################################################
$downloader.DownloadFile("http://cygwin.com/setup-x86_64.exe", "cygwin.exe")
iex "./cygwin.exe --disable-buggy-antivirus --no-admin --no-desktop --quiet-mode --root C:\cygwin\ --site http://linorg.usp.br/cygwin --packages git,mintty,openssh,python,ruby,zsh"


## Install citrix receiver
########################################################################
$downloader.DownloadFile("http://downloadplugins.citrix.com.edgesuite.net/Windows/CitrixReceiverWeb.exe", "citrix.exe")
iex "./citrix.exe" 


## Windows explorer tweaks
########################################################################
$key = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
Set-ItemProperty $key Hidden 1
Set-ItemProperty $key HideFileExt 0
Stop-Process -processname explorer

# Disable some startup programs
$key = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Run' 
Remove-ItemProperty $key Skype
Remove-ItemProperty $key uTorrent

# Disable Java Update
$key = 'HKLM:\SOFTWARE\Wow6432Node\JavaSoft\Java Update\Policy'
Set-ItemProperty $key EnableJavaUpdate 0

# Disable Aero
$key = 'HKCU:\Software\Microsoft\Windows\DWM'
Set-ItemProperty $key Composition 0
