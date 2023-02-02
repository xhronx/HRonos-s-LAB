Function Enable-WinRM {
    param(
        $computerName,        
        $testAttempts, #how many times to check if service is enabled
        $testIntervalSeconds #the time in seconds between each check
    )
   
    if (Test-Connection $computerName) {

        write-host "Successfully pinged $computerName"
        
        if (!(Test-WSMan $computerName -ErrorAction SilentlyContinue)) {

            #WinRM not enabled - enable it
            Invoke-WmiMethod -ComputerName $computerName -Path win32_process -Name create -ArgumentList "powershell.exe -command Enable-PSRemoting -SkipNetworkProfileCheck -Force"
            Invoke-WmiMethod -ComputerName $computerName -Path win32_process -Name create -ArgumentList "powershell.exe -command WinRM QuickConfig -Quiet"

            $currentAttempt = 1

            while (!(Test-WSMan $ComputerName -ErrorAction SilentlyContinue)) { 
              
                write-host "Attempt $currentAttempt..."
                
                if ($currentAttempt -eq $testAttempts) {
                    write-host "Could not enable WinRM on $ComputerName"
                    return $false
                }
                
                Start-Sleep -Seconds $testIntervalSeconds
                $currentAttempt ++
            }       
            
            write-host "WinRM enabled on $computerName"
            return $true

        } else {

            write-host "WinRM enabled on $computerName"
            return $true

        }
    } else {

         write-host "Cannot ping $computerName"
         return $false

    }

}

#specify machines to enable WinRM/run scriptblock on
$Computers = "localhost","MSK-PC095.ooo.ste.lan"

$scriptblock = {
    param($Computer)

    #enable remote registry service
    $returnMessage = ""

  $RemoteRegistry = Get-CimInstance -Class Win32_Service -ComputerName $Computer -Filter 'Name = "RemoteRegistry"' -ErrorAction Stop
      if ($RemoteRegistry.State -eq 'Running') {
            $returnMessage = "Remote registry on $Computer is already Enabled"
        }
 
        if ($RemoteRegistry.StartMode -eq 'Disabled') {
            Set-Service -Name RemoteRegistry -ComputerName $Computer -StartupType Manual -ErrorAction Stop
            $returnMessage = "Remote registry on $Computer has been Enabled"
        }
 
        if ($RemoteRegistry.State -eq 'Stopped') {
            Start-Service -InputObject (Get-Service -Name RemoteRegistry -ComputerName $Computer) -ErrorAction Stop
            $returnMessage = "Remote registry on $Computer has been Started"
        }
    return $returnMessage
}

foreach ($ComputerName in $Computers) {

    #try and enable PS Remoting - test if WinRM is enabled 2 times and wait 5 seconds in between testing
    if (Enable-WinRM $ComputerName 2 5) {    
        #if we manage to enable WinRM, we can then run whatever we want using Invoke-Command!      
        try {
            $returnMessage = Invoke-Command -ComputerName $ComputerName -ScriptBlock $scriptblock -ArgumentList $ComputerName
            write-host $returnMessage 
        } catch {
            write-host $_.exception.message
        }
    }

}
