$softwares = Get-CimInstance -ClassName Win32_Product | Select-Object Name, ID, Version, Vendor, InstallDate

Write-Host "logiciel installé:"
$softwares | Format-Table -AutoSize

$outputFile = "BOM.csv"
$softwares | Export-Csv -Path $outputFile -NoTypeInformation

Write-Host "Les informations sur les logiciels ont été exportées vers $outputFile"

$softwares | Export-Csv -Path $outputFile -NoTypeInformation
Write-Host "Les informations mises à jour sur les logiciels ont été exportées vers $outputFile"

$drivers = Get-WmiObject Win32_PnPSignedDriver | Select-Object DeviceName, DriverVersion, Manufacturer, Date
Write-Host "Pilotes installés:"
$drivers | Format-Table -AutoSize
$driversOutputFile = "Drivers.csv"
$drivers | Export-Csv -Path $driversOutputFile -NoTypeInformation
Write-Host "Les informations sur les pilotes ont été exportées vers $driversOutputFile"


