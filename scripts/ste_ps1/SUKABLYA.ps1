Restart-Computer -ComputerName msk-pc084.ooo.ste.lan -Credential ste\adm.s.trifonov -Force

(Get-WmiObject -cred $cred -Impersonation Delegate -Authentication PacketPrivacy -ComputerName msk-pc084.ooo.ste.lan -List | Where-Object -FilterScript ($_.Name -eq "Win32_Product")).Install('\\msk-pc075\c$\soft\AnyDesk.msi\')

Invoke-Command -ComputerName msk-pc032.ooo.ste.lan -Credential msk-pc032\steroot -ScriptBlock {Msiexec /i \\msk-pc075\c$\soft\AnyDesk.msi /log C:\MSIInstall.log}

Msiexec /i \\msk-pc075\c$\soft\AnyDesk.msi /log C:\MSIInstall.log

$session = New-PSSession -ComputerName $computerName
Copy-Item -Path $file -ToSession $session -Destination 'c:\windows\temp\installer.exe'

Invoke-Command -Session $session -ScriptBlock {
    c:\windows\temp\installer.exe /silent
}
Remove-PSSession $session

$session = New-PSSession -ComputerName msk-pc084.ooo.ste.lan -Credential ste\adm.s.trifonov
Invoke-Command -Session $session -ScriptBlock {Msiexec /i \\msk-pc075\c$\soft\AnyDesk.msi /log C:\MSIInstall.log}
Remove-PSSession $session

Get-PSSession | Disconnect-PSSession

Invoke-Command -ComputerName msk-pc084.ooo.ste.lan -Credential ste\adm.s.trifonov -ScriptBlock { Start-Process Msiexec "/i \\msk-pc075\c$\soft\AnyDesk.msi /quiet /lvx* c:\PackageManagement.log" -wait }

Get-WmiObject -Class win32_service -ComputerName omsk-pc032.ooo.ste.lan -Credential ste\adm.s.trifonov | Where-Object {$_.name -like "WinRM"}

Get-Service WinRM* | where-object {$_.Status -eq "Stopped"} | restart-service

Start-Service WinRM* -ComputerName msk-pc084.ooo.ste.lan -Credential ste\adm.s.trifonov | Where-Object {$_.name -like "WinRM"}

Get-Service SpooleWinRM*r -ComputerName msk-pc084.ooo.ste.lan | Start-Service

Test-NetConnection 10.10.12.44 -port 135




Get-WindowsCapability -Name RSAT* -Online | Select-Object -Property DisplayName, State

Add-WindowsCapability –online –Name Rsat.ActiveDirectory.DS-LDS.Tools~~~~0.0.1.0