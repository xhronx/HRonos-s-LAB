# Поиск неактивных и отключенных компьютеров/пользователей в Active Directory с помощью
# PowerShell

# Найти в определенном OU все компьютеры, которые не использовались для входа в сеть более 180 дней
$LastLogonDate= (Get-Date).AddDays(-180)
Get-ADComputer -Properties LastLogonTimeStamp -Filter {LastLogonTimeStamp -lt $LastLogonDate }  -SearchBase ‘OU=Computers,OU=MSK, dc=winitpro,dc=ru’| Sort LastLogonTimeStamp| FT Name, @{N='lastlogontimestamp'; E={[DateTime]::FromFileTime($_.lastlogontimestamp)}} -AutoSize | Export-CSV c:\ps\inactive_computers.csм

# Отключить найденные учетные записи компьютеров
Get-ADComputer -Properties LastLogonTimeStamp -Filter {LastLogonTimeStamp -lt $LastLogonDate }  -SearchBase ‘OU=Computers,OU=MSK,dc=winitpro,dc=ru’| Disable-ADAccount

# Перенести в отдельный OU найденные учетные записи компьютеров
Get-ADComputer -Properties LastLogonTimeStamp -Filter {LastLogonTimeStamp -lt $LastLogonDate }  -SearchBase ‘OU=Computers,OU=MSK,dc=winitpro,dc=ru’| Move-ADObject -TargetPath “OU=Disabled Computers,DC=winitpro,DC=ru”

# Удалить найденные учетные записи компьютеров
Get-ADComputer -Properties LastLogonTimeStamp -Filter {LastLogonTimeStamp -lt $LastLogonDate }  -SearchBase ‘OU=Computers,OU=MSK,dc=winitpro,dc=ru’| Remove-ADComputer

# Найти в определенном OU все УЗ, которые не использовались для входа в сеть более 180 дней
$LastLogonDate= (Get-Date).AddDays(-180)
Get-ADUser -Properties LastLogonTimeStamp -Filter {LastLogonTimeStamp -lt $LastLogonDate }  -SearchBase ‘OU=Users,OU=MSK,dc=winitpro,dc=ru’| ?{$_.Enabled –eq $True} |  Sort LastLogonTimeStamp| FT Name, @{N='lastlogontimestamp'; E={[DateTime]::FromFileTime($_.lastlogontimestamp)}} -AutoSize | Export-CSV c:\ps\inactive_users.csv

# Перенести в отдельный OU найденные УЗ
Get-ADUser -Properties LastLogonTimeStamp -Filter {LastLogonTimeStamp -lt $LastLogonDate }  -SearchBase ‘OU=Users,OU=MSK,dc=winitpro,dc=ru’| Disable-ADAccount

# Поиск УЗ(отключенных) в определённой OU
Search-ADAccount -UsersOnly –AccountDisabled –searchbase "OU=Admins,OU=Accounts,DC=winitpro,DC=loc"

## Cписок наиболее интересных ключей командлета Search-ADAccount 
# отключенных учетных записей --- -AccountDisabled
# с истекшим сроком действия учетки --- -AccountExpired
# которые просрочатся в течении определенного периода (-TimeSpan) или в определенную дату(-DateTime) --- -AccountExpiring [-DateTime DateTime] [-TimeSpan TimeSpan]
# не регистрировавшиеся в домене начиная с определенной даты(-DateTime) или в течении определенного периода времени (-TimeSpan) --- -AccountInactive [-DateTime DateTime] [-TimeSpan TimeSpan]
# заблокированные парольной политикой --- -LockedOut
# записи, пароль которых просрочен --- -PasswordExpired
# у которых установлен атрибут PasswordNeverExpires --- -PasswordNeverExpires

# Поиск УЗ(отключенных) в определённой OU в более удобном табличном виде
Search-ADAccount -UsersOnly -AccountDisabled -searchbase "OU=Admins,OU=Accounts,DC=winitpro,DC=loc"|ft -AutoSize

# Список отключенных пользователей, содержащий только определённые атрибуты пользователей и представить в виде графической таблицы с возможностью сортировки
Search-ADAccount -UsersOnly -AccountDisabled |sort LastLogonDate | Select Name,LastLogonDate,DistinguishedName |out-gridview -title "Disabled Users"

# Список учетных записей пользователей, неактивных в течении 60 дней
$timespan = New-Timespan –Days 60
Search-ADAccount –UsersOnly –AccountInactive –TimeSpan $timespan | ?{$_.Enabled –eq $True}

# Колличество учетных записей пользователей, неактивных в течении 60 дней
Search-ADAccount –UsersOnly –AccountInactive –TimeSpan $timespan | ?{$_.Enabled –eq $True} | Measure

# Список компьютеров, которые не регистрировались в домене в течении последних 90 дней
Search-ADAccount -AccountInactive –ComputersOnly -TimeSpan 90

# Cписок компьютеров, которые не регистрировались в домене с определенной даты(1/1/2020)
Search-ADAccount -AccountInactive -ComputersOnly -DateTime ‘1/1/2020’|Select Name,LastLogonDate| ft

# Выгрузка полученных данных(напр. отключенных учетных записей пользователей) в CSV файл
Search-ADAccount -AccountDisabled -UsersOnly| Export-Csv "c:\ps\disabled_users.csv"

#
