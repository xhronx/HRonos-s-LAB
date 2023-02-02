# Одобрение обновлений WSUS с помощью
# PowerShell

# Для подключений к WSUS серверу из консоли PowerShell
$WsusServerFqdn='msk-wsus.winitpro.loc'
[void][reflection.assembly]::LoadWithPartialName( «Microsoft.UpdateServices.Administration)
$wsus = [Microsoft.UpdateServices.Administration.AdminProxy]::getUpdateServer( $WsusServerFqdn, $False, '8530')

# запустить синхронизацию обновлений:
$wsus.GetSubscription().StartSynchronization();

# Вывести список групп компьютеров на WSUS:
$wsus.GetComputerTargetGroups()

# Выбрать конкретную группу компьютеров:
$group = $wsus.GetComputerTargetGroups() | ? {$_.Name -eq "Test_WKS_WSUS"}

# Для получения списка последних обновлений можно использовать метод GetUpdates. 
$updates = $wsus.GetUpdates() | ? {($_.CreationDate -gt "5/1/2022" -and $_.CreationDate -lt "6/1/2022" -and $_.Title -notmatch ".net Framework" -and $_.PublicationState -ne "Expired" ) -and ($_.ProductFamilyTitles -eq "Windows" -or $_.ProductFamilyTitles -eq "Office") -and ($_.UpdateClassificationTitle -eq "Security Updates" -or $_.UpdateClassificationTitle -eq "Critical Updates")}
Теперь вы можете одобрить выбранные обновления для установки на указанную группу:
foreach ($update in $updates)
{
$update.Approve(“Install”,$group)

# Для получения списка последних обновлений можно использовать модуль UpdateServices.
$data = (Get-Date).adddays(-14)
$wsus= Get-WSUSServer -Name wsusservername -Port 8530
Get-WsusUpdate -UpdateServer $wsus -Approval Unapproved -Status Needed
Get-WsusUpdate -Classification All -Approval Unapproved | Where-Object { ($_.Update.CreationDate -lt $data) -and ($_.update.isdeclined -ne $true) and {$_.update.title -ilike "*Windows*" -or $_.update.title -ilike "*Office*"} | | Approve-WsusUpdate -Action Install -TargetGroupName "Test_WKS_WSUS"

# скрипт, который собирает список обновлений, одобренных для тестовой группы и автоматически одобряет все обнаруженные обновления на продуктивную группу
$WsusServerFqdn='msk-wsus.winitpro.loc'
$WsusSourceGroup = 'Workstation_Test'
$WsusTargetGroup = 'WorkstationProduction'
[void][reflection.assembly]::LoadWithPartialName(ЭMicrosoft.UpdateServices.AdministrationЭ)
$wsus = [Microsoft.UpdateServices.Administration.AdminProxy]::getUpdateServer( $WsusServerFqdn, $False, ‘8530’)
$Groups = $wsus.GetComputerTargetGroups()
$WsusTargetGroupObj = $Groups | Where {$_.Name -eq $WsusTargetGroup}
$Updates = $wsus.GetUpdates()
$i = 0
ForEach ($Update in $Updates)
{
if ($Update.GetUpdateApprovals($WsusSourceGroupObj).Count -ne 0 -and $Update.GetUpdateApprovals($WsusTargetGroupObj).Count -eq 0)
{
$i ++
Write-Host ("Approving" + $Update.Title)
$Update.Approve('Install',$WsusTargetGroupObj) | Out-Null
}
}
Write-Output ("Approved {0} updates for target group {1}" -f $i, $WsusTargetGroup)


#

