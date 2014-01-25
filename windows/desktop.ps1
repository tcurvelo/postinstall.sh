#######
## Post-install script for a windows desktop
########################################################################
# usage:
#     @powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString('https://raw.github.com/tcurvelo/postinstall.sh/master/windows/desktop.ps1'))"


$downloader = new-object System.Net.WebClient


## Install chocolatey
########################################################################
iex $downloader.DownloadString("https://chocolatey.org/install.ps1")
$env:Path += ";%systemdrive%\chocolatey\bin"


## Install packages from chocolatey gallery
########################################################################

iex @"
cinst ccleaner
cinst dropbox
cinst Firefox
cinst gimp
cinst GoogleChrome
cinst InkScape
cinst launchy
cinst skype
cinst steam
cinst SublimeText3
cinst virtualbox
cinst vlc
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
Set-ItemProperty $key ShowSuperHidden 1
Stop-Process -processname explorer
