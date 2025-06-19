$softwares = WmiObject -Class Win32_Product | Select-Object -Property Name, Version 
write-host "Installed Software:" $softwares 

