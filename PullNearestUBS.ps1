param (
    [double]$lat,
    [double]$lon
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

#Function definition to get distance between two points
function Get-Distance {
    param (
        [double]$lat1,
        [double]$lon1,
        [double]$lat2,
        [double]$lon2
    )
    process {
        [double]$c1 = ($lat2 - $lat1)
        [double]$c2 = ($lon2 - $lon1)
        [Math]::Sqrt($c1*$c1 + $c2*$c2)
    }
}

if ($lat -and $lon) {
    $ubs_mais_proxima = $null
    [double]$menor_distancia = 2000 # Set a large number
    foreach ($u in $ubs) {
        [double]$distancia = Get-Distance -lat1 $lat -lon1 $lon -lat2 $u.vlr_latitude -lon2 $u.vlr_longitude
        if ($distancia -le $menor_distancia) {
            $menor_distancia = $distancia
            $ubs_mais_proxima = $u
        }
    }
    #Return city found
    if ($ubs_mais_proxima) {
        $ubs_mais_proxima | ConvertTo-Html -Property dsc_cidade, nom_estab, dsc_endereco, dsc_bairro
    }
}