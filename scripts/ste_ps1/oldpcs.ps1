# Поиск неактивных и отключенных компьютеров в Active Directory с помощью 
# PowerShell

$date_with_offset= (Get-Date).AddDays(-120)
Get-ADComputer -Properties LastLogonDate -Filter {LastLogonDate -lt $date_with_offset } | Sort LastLogonDate | FT Name, LastLogonDate -AutoSize | Out-File C:\Users\adm.s.trifonov\Desktop\services-120.txt