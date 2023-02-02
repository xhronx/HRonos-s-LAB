#
#

# изменить имя компьютера
Rename-Computer -NewName "wks-test1"

# для добавления в домен
Add-Computer -DomainName contoso.com

# поместить ваш компьютер в нужную OU
$OU ="OU=Computers,OU=SPB,OU=RU,DC=contosoc,DC=loc"
Add-Computer -DomainName contoso.loc -OUPath $OU -Restart

# проверить, что ваш компьютер теперь является членом домена
Get-WmiObject Win32_NTDomain

# получить имя вашего домена
systeminfo | findstr /B "Domain"

# добавить удаленный компьютер в домен
Add-Computer -ComputerName wks-pc22 -DomainName contoso.com -Credential contoso\Administrator -LocalCredential wks-pc22\Admin -Restart –Force

# вывести компьютер из домена и вернуть его в рабочую группу
Remove-Computer

# предварительно создать учетную запись компьютера в Active Directory 
New-ADComputer -Name "wks-msk022" -SamAccountName "wks-msk022" -Path "OU=Computers,OU=MSK,OU=RU,DC=contoso,DC=loc"

# сбросить учетную запись компьютера в AD
Get-ADComputer -Identity "computername" | % {dsmod computer $_.distinguishedName -reset}

###

# способ удаления программы в Windows с помощью PowerShell
Get-Package -name “*Microsoft Edge*” | Uninstall-Package

# полный список TCP и UDP портов, которые прослушиваются вашим компьютером
netstat -aon| find "LIST"

# указать искомый номер порта
netstat -aon | findstr ":80" | findstr "LISTENING"

# определить исполняемый exe файл процесса с этим PID
tasklist /FI "PID eq 16124"
# ИЛИ
for /f "tokens=5" %a in ('netstat -aon ^| findstr :80') do tasklist /FI "PID eq %a"

# получить имя процесса, который прослушивает
# TCP порт
Get-Process -Id (Get-NetTCPConnection -LocalPort 80).OwningProcess
# UDP порт
Get-Process -Id (Get-NetUDPEndpoint -LocalPort 53).OwningProcess

# завершить этот процесс, отправив результаты через pipe
Get-Process -Id (Get-NetTCPConnection -LocalPort 80).OwningProcess| Stop-Process

# Проверьте, что порт теперь свободен
Test-NetConnection localhost -port 80

#
