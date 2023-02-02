$sites = [System.DirectoryServices.ActiveDirectory.Forest]::GetCurrentForest().Sites           

foreach ($site in $sites) {   
    write-host "(site) $site"    
    foreach ($subnet in $site.Subnets) {
        write-host "....(subnet) $subnet"
        foreach ($server in $site.Servers) {
            write-host "........(server) $server"
        }
    }
}