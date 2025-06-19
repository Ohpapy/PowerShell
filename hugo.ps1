$softwares = Get-WmiObject -Class Win32_Product | Select-Object -Property Name, Version, Vendor, InstallDate

Write-Host "logiciel installé:"
$softwares | Format-Table -AutoSize

$outputFile = "SoftwareInventory.csv"
$softwares | Export-Csv -Path $outputFile -NoTypeInformation

Write-Host "Les informations sur les logiciels ont été exportées vers $outputFile"

function Add-ManualSoftware {
    param (
        [string]$Name,
        [string]$Version,
        [string]$Vendor
    )

    $newSoftware = [PSCustomObject]@{
        Name = $Name
        Version = $Version
        Vendor = $Vendor
        InstallDate = (Get-Date).ToString('yyyyMMdd')
    }

    $softwares += $newSoftware
    Write-Host "Logiciel ajouté : $Name"
}

Add-ManualSoftware -Name "MonLogiciel" -Version "1.0.0" -Vendor "MonEntreprise"

$softwares | Export-Csv -Path $outputFile -NoTypeInformation
Write-Host "Les informations mises à jour sur les logiciels ont été exportées vers $outputFile"
