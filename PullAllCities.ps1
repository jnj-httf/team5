param (
    [string]$city
)
[string]$path = "$env:TEMP\ubs.json"

#Build cache file if one does not exist
if ((Test-Path -Path $path)) {
    $ubs = Get-Content -Path $path | ConvertFrom-Json
}
else {
    Write-Error "Cache file not found. Building it" -ErrorAction Continue

    [int]$pages = (Invoke-RestMethod -Uri "http://api-ldc-hackathon.herokuapp.com/api/ubs/" | Select-Object -ExpandProperty _metadata | Select-Object -ExpandProperty page) -split "/" | Select-Object -Last 1

    $ubs = Invoke-Command {
         for ($i = 1; $i -le $pages; $i++) {
            $ubs = Invoke-RestMethod -Uri "http://api-ldc-hackathon.herokuapp.com/api/ubs/$i/"
            $ubs.records
         }
    }
    $ubs | ConvertTo-Json | Out-File -Encoding utf8 $path
}

#Function definition to remove accents and multiple spaces from string
function Remove-Accents {
    param (
        [string]$s
    )
    process {
        $s -ireplace "[áã]", "a" -ireplace "[éê]", "e" -ireplace "[í]", "i" -ireplace "[óôõ]", "0" -ireplace "[ú]", "u" -ireplace "\s+", " "
    }
}

$ubs | Where-Object { !$city -or (Remove-Accents -s $_.dsc_cidade) -imatch "$(Remove-Accents -s $city).*" } | Select-Object -ExpandProperty dsc_cidade -Unique | Sort-Object