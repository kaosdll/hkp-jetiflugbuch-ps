###################################################################################################################
# hkp-jetiflugbuch-ps ; Version 0.1 vom 23.06.2015 ; Manuel Kuss (manuel@hangkantenpolitur.de)
# GitHub: https://github.com/kaosdll/hkp_jetilog_flugbuch ; GNU General Public License v2.0
###################################################################################################################
$logpath = "*"
$minsize = 1024 # Mindestgröße der Logdatei in Bytes
$scriptRoot = Split-Path -Path $MyInvocation.MyCommand.Path # Script Root (noch keine Funktion)
echo "DATUM`tSTART`tENDE`tMODELL" | out-file flugbuch.csv # Dateiheader schreiben
$files = Get-ChildItem -Path $logpath -Filter *.log | Where-Object {$_.Length -ge $minsize} # Dateiliste aufbauen
foreach ($item in $files) # Logs verarbeiten
    {
    $model = Get-Content $Item -totalcount 1 # Modellname
    $datum = "{0:dd.MM.yyyy}" -f (Get-Date $Item.LastWriteTime) # Datum (LastWriteTime)
    $start = $item.Name.Split(".")[0] # Startzeit (Filename)
    $ende = "{0:HH:mm:ss}" -f (Get-Date $Item.LastWriteTime) # Endzeit (LastWriteTime)
    $output = $datum + "`t" + $start.Replace("-",":") + "`t" + $ende + "`t" + $model.Remove(0,2) # Verkettung und Umformatierungen
    $output | out-file flugbuch.csv -Append # Dateiausgabe
    echo $output # Konsole
   }
