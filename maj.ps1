#RECUPERATION DES INFOS DU CSV

$csvfile = Import-Csv -Path "./forme.csv"

#LECTURE CVS ET TRAITEMENT DES MISE A JOUR

#sortie de la commande winget search
#Nom                     ID                             Version        Source
#-----------------------------------------------------------------------------
#Windows PC Health Check Microsoft.WindowsPCHealthCheck 3.7.2204.15001 winget

foreach ($info in $csvfile) {
        $name = $info.Name
        $vendor = $info.Vendor
        $version = $info.Version
    if ($name -eq "none", $vendor -eq "none", $version -eq "none") {
        Write-Output "Aucune entrée n'est renseignée, on ne peut pas la traiter"
    } else {
        if($vendor -like "*Microsoft*") {

        $update = winget search --name $name | Select-String $name
        # Write-Output "Version locale : $version"
        # Write-Output "Disponible sur winget : $update"
        # Write-Output "Vendeur : $vendor"
        # Write-Output "----------------------------------------"
        
        $ligne = $update -split '\s{2,}'
        $versiondispo = $ligne[2]
        $id = $ligne[1]
        if ($versiondispo -eq ""){
            Write-Output "Pas de version disponible sur winget"
        } else {
            if ($versiondispo -eq $version) {
                Write-Output "La version est à jour"
            } else {
                Write-Output "La version de $name n'est pas a jour prenez la version $versiondispo"
                Read-Host "Voulez-vous mettre à jour $name ? (O/N)"
                $response = $input
                if ($response -eq "O") {
                    Write-Output "Mise à jour de $name"
                    winget upgrade --id $id --version $versiondispo
                } else {
                    Write-Output "Mise à jour de $name annulée"
                }
            }
        }
        } else {
            Write-Output "Le vendeur n'est pas Microsoft, on ne peut pas le traiter"

        }
    }
}