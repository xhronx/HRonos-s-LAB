$username = "testroot1"
$password = ConvertTo-SecureString "7JV#3pGb" -AsPlainText -Force  # Super strong plane text password here (yes this isn't secure at all)
        New-LocalUser "$username" -Password $password -FullName "$username" -Description "local admin"
        Write-Log -message "$username local user crated"
        Add-LocalGroupMember -Group "Administrators" -Member "$username"
        Add-LocalGroupMember -Group "Администраторы" -Member "$username" -ErrorAction stop
        Write-Log -message "$username added to the local administrator group"