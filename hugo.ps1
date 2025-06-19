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

$computerSystem = Get-CimInstance -ClassName Win32_ComputerSystem | Select-Object Manufacturer, Model
$processor = Get-CimInstance -ClassName Win32_Processor | Select-Object -First 1 Name, NumberOfCores, NumberOfLogicalProcessors
$memory = Get-CimInstance -ClassName Win32_PhysicalMemory | Select-Object -First 1 Manufacturer, Capacity, Speed
$battery = Get-CimInstance -ClassName Win32_Battery | Select-Object -First 1 Name, EstimatedChargeRemaining, DesignCapacity, Status

$hardware = [PSCustomObject]@{
	Manufacturer                = $computerSystem.Manufacturer
	Model                       = $computerSystem.Model
	ProcessorName               = $processor.Name
	ProcessorCores              = $processor.NumberOfCores
	ProcessorLogicalProcessors  = $processor.NumberOfLogicalProcessors
	MemoryManufacturer          = $memory.Manufacturer
	MemoryCapacity              = $memory.Capacity
	MemorySpeed                 = $memory.Speed
	BatteryName                 = $battery.Name
	BatteryEstimatedCharge      = $battery.EstimatedChargeRemaining
	BatteryDesignCapacity       = $battery.DesignCapacity
	BatteryStatus               = $battery.Status
}

Write-Host "Informations sur le matériel:"

$hardware | Format-Table -AutoSize

$hardwareOutputFile = "Hardware.csv"    

$hardware | Export-Csv -Path $hardwareOutputFile -NoTypeInformation

Write-Host "Les informations sur le matériel ont été exportées vers $hardwareOutputFile"

$os = Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object Caption, Version, BuildNumber, OSArchitecture

Write-Host "Informations sur le système d'exploitation:"

$os | Format-Table -AutoSize

$osOutputFile = "OS.csv"

$os | Export-Csv -Path $osOutputFile -NoTypeInformation

Write-Host "Les informations sur le système d'exploitation ont été exportées vers $osOutputFile"
