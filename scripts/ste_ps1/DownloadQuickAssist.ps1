REM disable using internal WU server
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v UseWUServer /t REG_DWORD /d 0 /f 
net stop "Windows Update" 
net start "Windows Update"

REM Install Option feature(s)
dism /Online /Add-Capability /CapabilityName:App.Support.QuickAssist~~~~0.0.1.0

REM enable using WU server
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v UseWUServer /t REG_DWORD /d 1 /f 
net stop "Windows Update" 
net start "Windows Update"