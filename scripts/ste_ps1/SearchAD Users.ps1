$searcher=[adsisearcher]'(&(objectCategory=person)(objectClass=user))'
$searcher.PageSize = 200

$colProplist = "samaccountname"
foreach ($i in $colPropList) { $searcher.PropertiesToLoad.Add($i) | out-null } 
        
$Users = $searcher.findall()
foreach ($user in $Users) {
       write-host ($user.Properties).samaccountname
}  