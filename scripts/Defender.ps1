# Антивирус Windows Defender в Windows Server 2019 и 2016
# Powershell


# проверить наличие установленного компонента Windows Defender Antivirus
Get-WindowsFeature | Where-Object {$_. name -like "*defender*"} | ft Name,DisplayName,Installstate

# Установить графический компонент антивируса Windows Defender
Install-WindowsFeature -Name Windows-Defender-GUI

# Для удаления графического консоли Defender
Uninstall-WindowsFeature -Name Windows-Defender-GUI

# ошибка “You’ll need a new app to open this windowsdefender”, нужно перерегистрировать APPX приложение с помощью файла манифеста
Add-AppxPackage -Register -DisableDevelopmentMode "C:\Windows\SystemApps\Microsoft.Windows.SecHealthUI_cw5n1h2txyewy\AppXManifest.xml"

# Удалить компонент Windows Defender
Uninstall-WindowsFeature -Name Windows-Defender

# Установить службы Windows Defender
Add-WindowsFeature Windows-Defender-Features,Windows-Defender-GUI

# Проверить, запущена ли служба Windows Defender Antivirus Service
Get-Service WinDefend

# Текущие настройки и статус Defender
Get-MpComputerStatus

# Отключить защиту в реальном времени Windows Defender (RealTimeProtectionEnabled)
Set-MpPreference -DisableRealtimeMonitoring $true

# Включить защиту в реальном времени
Set-MpPreference -DisableRealtimeMonitoring $false

# отключить автоматические исключения Microsoft Defender
Set-MpPreference -DisableAutoExclusions $true

# вручную добавить определенные каталоги в список исключения антивируса
Set-MpPreference -ExclusionPath "C:\Test", "C:\VM", "C:\Nano"

# исключить антивирусную проверку определенных процессов
Set-MpPreference -ExclusionProcess "vmms.exe", "Vmwp.exe"

# удаленно опросить состояние Microsoft Defender на удаленных компьютерах
# скрипт при помощи командлета Get-ADComputer выберет все Windows Server хосты в домене и через WinRM (командлетом Invoke-Command) получит состояние антивируса
$Report = @()
$servers= Get-ADComputer -Filter 'operatingsystem -like "*server*" -and enabled -eq "true"'| Select-Object -ExpandProperty Name
foreach ($server in $servers) {
$defenderinfo= Invoke-Command $server -ScriptBlock {Get-MpComputerStatus | Select-Object -Property Antivirusenabled,RealTimeProtectionEnabled,AntivirusSignatureLastUpdated,QuickScanAge,FullScanAge}
If ($defenderinfo) {
$objReport = [PSCustomObject]@{
User = $defenderinfo.PSComputername
Antivirusenabled = $defenderinfo.Antivirusenabled
RealTimeProtectionEnabled = $defenderinfo.RealTimeProtectionEnabled
AntivirusSignatureLastUpdated = $defenderinfo.AntivirusSignatureLastUpdated
QuickScanAge = $defenderinfo.QuickScanAge
FullScanAge = $defenderinfo.FullScanAge
}
$Report += $objReport
}
}
$Report|ft
 
# Для получения информации о срабатываниях антивируса с удаленных компьютеров
$Report = @()
$servers= Get-ADComputer -Filter 'operatingsystem -like "*server*" -and enabled -eq "true"'| Select-Object -ExpandProperty Name
foreach ($server in $servers) {
$defenderalerts= Invoke-Command $server -ScriptBlock {Get-MpThreatDetection | Select-Object -Property DomainUser,ProcessName,InitialDetectionTime ,CleaningActionID,Resources }
If ($defenderalerts) {
foreach ($defenderalert in $defenderalerts) {
$objReport = [PSCustomObject]@{
Computer = $defenderalert.PSComputername
DomainUser = $defenderalert.DomainUser
ProcessName = $defenderalert.ProcessName
InitialDetectionTime = $defenderalert.InitialDetectionTime
CleaningActionID = $defenderalert.CleaningActionID
Resources = $defenderalert.Resources
}
$Report += $objReport
}
}
}
$Report|ft

# сбросить текущие базы и перекачать их заново
"%PROGRAMFILES%\Windows Defender\MPCMDRUN.exe" -RemoveDefinitions -All
"%PROGRAMFILES%\Windows Defender\MPCMDRUN.exe" –SignatureUpdate

# Скачайте обновления Windows Defender вручную (https://www.microsoft.com/en-us/wdsi/defenderupdates) и помесите в сетевую папку
# путь к сетевому каталогу с обновлениями в настройках Defender
Set-MpPreference -SignatureDefinitionUpdateFileSharesSources \\fs01\Updates\Defender
# Запустите обновление базы сигнатур
Update-MpSignature -UpdateSource FileShares


#





