# POWERSHELL
# Найти все файловые сервера c ролью FileAndStorage-Services в указанном контейнере AD

import-module activedirectory
$Servers=get-adcomputer -properties * -Filter {Operatingsystem -notlike "*2008*" -and enabled -eq "true" -and Operatingsystem -like "*Windows Server*"} -SearchBase ‘OU=Servers,OU=MSK,DC=winitpro.ru,DC=ru’ |select name
Foreach ($server in $Servers)
{
Get-WindowsFeature -name FileAndStorage-Services -ComputerName $server.Name | Where installed | ft $server.name, Name, Installstate
}
