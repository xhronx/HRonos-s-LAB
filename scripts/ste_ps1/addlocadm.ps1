$username = "testroot"
$password = ConvertTo-SecureString "7JV#3pGb" -AsPlainText -Force  # Super strong plane text password here (yes this isn't secure at all)
$logFile = "C:\Windows\Temp\log_addladm.txt"

Function Write-Log {
  param(
      [Parameter(Mandatory = $true)][string] $message,
      [Parameter(Mandatory = $false)]
      [ValidateSet("INFO","WARN","ERROR")]
      [string] $level = "INFO"
  )
  # Create timestamp
  $timestamp = (Get-Date).toString("yyyy/MM/dd HH:mm:ss")

  # Append content to log file
  Add-Content -Path $logFile -Value "$timestamp [$level] - $message"
}

Function Create-LocalAdmin {
    process {
      try {
        New-LocalUser "$username" -Password $password -FullName "$username" -Description "local admin"
        Write-Log -message "$username local user crated"

        # Add new user to administrator group
        Add-LocalGroupMember -Group "Administrators" -Member "$username"
        Add-LocalGroupMember -Group "Администраторы" -Member "$username" -ErrorAction stop
        Write-Log -message "$username added to the local administrator group"
      }catch{
        Write-log -message "Creating local account failed" -level "ERROR"
      }
    }    
}

Write-Log -message "#########"
Write-Log -message "$env:COMPUTERNAME - Create local admin account"

Create-LocalAdmin

Write-Log -message "#########"