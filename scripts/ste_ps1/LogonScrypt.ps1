$val = Get-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "UseWUServer" | select -ExpandProperty UseWUServer
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "UseWUServer" -Value 0
Restart-Service wuauserv
Add-WindowsCapability �online �Name �Rsat.ActiveDirectory.DS-LDS.Tools~~~~0.0.1.0�
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "UseWUServer" -Value $val
Restart-Service wuauserv
$curhostname=$env:computername
$currus_cn=(get-aduser $env:UserName -properties *).DistinguishedName
$ADComp = Get-ADComputer -Identity $curhostname
$ADComp.description = $currus_cn
Set-ADComputer -Instance $ADComp