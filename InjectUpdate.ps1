$downloadLink = "https://catalog.sf.dl.delivery.mp.microsoft.com/filestreamingservice/files/a2fe5398-6f24-46ee-a533-372dc30bfd82/public/windows11.0-kb5039212-x64_2b67855a5e73c7a873e6bdca512c8c106b429196.msu"
$DestinationName = $downloadLink.Split("/")[$downloadLink.Split("/").Count-1]
$UpdateLocation = "C:\temp"

If(!(Test-Path -Path "$UpdateLocation\$DestinationName"))
{
    Remove-Item -Path $UpdateLocation\*.msu -Force
    Save-WebFile -SourceUrl $DownloadLink -DestinationDirectory $UpdateLocation -DestinationName $DestinationName
}

$UpdateFile = (Get-ChildItem -Path "$UpdateLocation\*.msu" | Select-Object -First 1).Name
If($UpdateFile){
dism /image:W:\ /add-package /packagepath:"$UpdateLocation\$UpdateFile"
}
