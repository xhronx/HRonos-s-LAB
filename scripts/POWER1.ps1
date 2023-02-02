# Это скрипты для установки и настройки SERVERов WINDOWS в
# POWERSHELL
# Статья: https://winitpro.ru/index.php/2019/09/13/upravlenie-roles-features-windows-iz-powershell/

# Вывести список всех доступных ролей и компонентов Windows Server
Get-WindowsFeature

# Роли и компоненты удаляются из образа так:
Uninstall-WindowsFeature –Name DHCP –Remove

# Установить удаленную роль, воспользуйтесь командлетом:
Install-WindowsFeature DHCP

# Восстановить компоненты их дистрибутива с вашей версией Windows Server
Install-WindowsFeature DHCP -Source E:\sources\sxs

# Вывести список установленных компонентов сервера
Get-WindowsFeature | Where-Object {$_. installstate -eq "installed"} | ft Name,Installstate

# Вывести список установленных компонентов на удаленном Windows Server
Get-WindowsFeature -ComputerName msk-prnt1 | Where installed | ft Name,Installstate

# Проверить какие из web компонентов роли IIS установлены
Get-WindowsFeature -Name web-* | Where installed #Полезно, если вы не знаете точно имя роли

# Установить роль DNS на текущем сервере и инструменты управления
Install-WindowsFeature DNS -IncludeManagementTools

# Вывести список зависимостей до установки 
Install-WindowsFeature -name UpdateServices -whatif

# Проверить, открыт ли порт(8530) на сервере(wsussrv1)
Test-NetConnection -ComputerName wsussrv1 -Port 8530

# Для установки компонента Rsat.WSUS.Tool(Windows 10 или 11)
Add-WindowsCapability -Online -Name Rsat.WSUS.Tools~~~~0.0.1.0

# Для установки компонента Rsat.WSUS.Tool(Windows Server)
Install-WindowsFeature -Name UpdateServices-Ui

# Устаноовить роль Remote Desktop Session Host, службу лицензирования RDS и утилиты управления RDS на удаленном сервере(msk-rds21)
Install-WindowsFeature -ComputerName msk-rds21 RDS-RD-Server, RDS-Licensing –IncludeAllSubFeature –IncludeManagementTools –Restart

# Альтернативкая установка компонента(например роль SMTP сервера)
Get-WindowsFeature -Name SMTP-Server | Install-WindowsFeature

# Экспортировать список установленных ролей в CSV файл
Get-WindowsFeature | where{$_.Installed -eq $True} | select name | Export-Csv C:\ps\Roles.csv -NoTypeInformation –Verbose

# Использовать CSV файл для установки такого же набора ролей на других типовых серверах
Import-Csv C:\PS\Roles.csv | foreach{ Install-WindowsFeature $_.name }

# Альтернативно, для установки одинакового набора ролей сразу на нескольких серверах можно использовать
$servers = ('srv1', 'srv2',’srv3’)
foreach ($server in $servers) {Install-WindowsFeature RDS-RD-Server -ComputerName $server}

# Удалить роль или компонент(напр, Print-Server) в Windows Server
Remove-WindowsFeature Print-Server -Restart

# 
