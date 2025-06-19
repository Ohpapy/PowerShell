# Récupérer les informations sur les logiciels installés
$softwares = Get-WmiObject -Class Win32_Product | Select-Object -Property Name, Version, Vendor, InstallDate

# Afficher les informations à l'écran
Write-Host "Installed Software:"
$softwares | Format-Table -AutoSize

# Exporter les résultats dans un fichier CSV
$outputFile = "SoftwareInventory.csv"
$softwares | Export-Csv -Path $outputFile -NoTypeInformation

Write-Host "Les informations sur les logiciels ont été exportées vers $outputFile"

# Fonction pour ajouter manuellement un logiciel
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

# Exemple d'ajout manuel d'un logiciel
Add-ManualSoftware -Name "MonLogiciel" -Version "1.0.0" -Vendor "MonEntreprise"

# Réexporter les résultats mis à jour
$softwares | Export-Csv -Path $outputFile -NoTypeInformation
Write-Host "Les informations mises à jour sur les logiciels ont été exportées vers $outputFile"
