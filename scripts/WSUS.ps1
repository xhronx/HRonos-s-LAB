# Это скрипты для установки и настройки WSUS в
# POWERSHELL
# Ссылка на статью: https://winitpro.ru/index.php/2013/04/11/ustanovka-wsus-na-windows-server-2012/

# Для установки роли сервера обновлений WSUS, необходимо установить некоторые компоненты IIS
What if: Continue with installation?
What if: Performing installation for "[Windows Server Update Services] Windows Server Update
What if: Performing installation for "[Windows Server Update Services] WID Database".
What if: Performing installation for "[Windows Server Update Services] WSUS Services".
What if: Performing installation for "[Web Server (IIS)] Windows Authentication".
What if: Performing installation for "[Web Server (IIS)] Dynamic Content Compression".
What if: Performing installation for "[Web Server (IIS)] Performance".
What if: Performing installation for "[Web Server (IIS)] Static Content".
What if: Performing installation for "[Windows Internal Database] Windows Internal Database".
What if: The target server may need to be restarted after the installation completes.
# Хз, как это использовать...

# Установить сервер WSUS с внутренней базой данный WID с помощью PowerShell командлета Install-WindowsFeature:
Install-WindowsFeature -Name UpdateServices, UpdateServices-WidDB, UpdateServices-Services, UpdateServices-RSAT, UpdateServices-API, UpdateServices-UI –IncludeManagementTools

# Чтобы указать путь к каталогу с файлами обновлений WSUS. Можно использовать консольную утилиту WsusUtil.exe
C:\Program Files\Update Services\Tools\WsusUtil.exe PostInstall CONTENT_DIR=E:\WSUS

# Перенастроить ваш WSUS на внешнюю базу данных SQL Server
C:\Program Files\Update Services\Tools\wsusutil.exe postinstall SQL_INSTANCE_NAME="SQLSRV1\SQLINSTANCEWSUS" CONTENT_DIR=E:\WSUS_Content

# Оптимизировать настройки пула IIS (Не обязательно, ссылка: https://winitpro.ru/index.php/2017/08/10/oshibka-0x80244022-i-problema-ostanovki-wsuspool/)
Import-Module WebAdministration
Set-ItemProperty -Path IIS:\AppPools\WsusPool -Name queueLength -Value 2500
Set-ItemProperty -Path IIS:\AppPools\WsusPool -Name cpu.resetInterval -Value "00.00:15:00"
Set-ItemProperty -Path IIS:\AppPools\WsusPool -Name recycling.periodicRestart.privateMemory -Value 0
Set-ItemProperty -Path IIS:\AppPools\WsusPool -Name failure.loadBalancerCapabilities -Value "TcpLevel"

#
