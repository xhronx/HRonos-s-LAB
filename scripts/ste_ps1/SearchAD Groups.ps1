#only groups
$objSearcher=[adsisearcher]'(&(objectCategory=group))'
$objSearcher.PageSize = 200

#specify properties to include
$colProplist = "name"
foreach ($i in $colPropList) { $objSearcher.PropertiesToLoad.Add($i) | out-null } 
	
$colResults = $objSearcher.FindAll()

foreach ($objResult in $colResults)
{
    #group name
    $groupname = ($objResult.Properties).name    
    write-host $groupname  		
}