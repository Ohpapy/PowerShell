$csvfile = Import-Csv -Path "./SoftwareInventory.csv"

foreach ($info in $csvfile) {
    $name = $info.Name
    $vendor = $info.Vendor
    $version = $info.Version

    if ($name -eq "none" -or $vendor -eq "none" -or $version -eq "none") {
        Write-Output "Aucune entrée n'est renseignee, on ne peut pas la traiter"
        continue
    }

    if ($vendor -like "*Microsoft*") {
        $searchResult = winget search --name $name | Select-String -SimpleMatch $name

        if (-not $searchResult) {
            Write-Output "Aucune version trouvee sur winget pour $name"
            continue
        }

        $ligne = ($searchResult -split '\s{2,}').Trim()
        $id = $ligne[1]
        $versionDispo = $ligne[2]

        if (-not $versionDispo -or $versionDispo.Trim() -eq "") {
            Write-Output "Pas de version disponible sur winget pour $name"
        }
        elseif ($versionDispo -eq $version) {
            Write-Output "La version de $name est à jour ($version)"
        }
        else {
            Write-Output "La version de $name n'est pas a jour. Version installee : $version. Version disponible : $versionDispo"
            $response = Read-Host "Voulez-vous mettre à jour $name ? (O/N)"

            if ($response -eq "O") {
                Write-Output "Mise à jour de $name..."
                winget upgrade --id $id --version $versionDispo
            }
            else {
                Write-Output "Mise à jour de $name abandon"
            }
        }
    }
    else {
        Write-Output "Le vendeur n'est pas Microsoft, on ne peut pas le traiter"
    }
}
