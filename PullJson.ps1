[double]$lat = -5.89795231819139
[double]$lon = -44.8160004615773

#[int]$pages = (Invoke-RestMethod -Uri "http://api-ldc-hackathon.herokuapp.com/api/ubs/" | Select-Object -ExpandProperty _metadata | Select-Object -ExpandProperty page) -split "/" | Select-Object -Last 1

#Invoke-Command {
#     for ($i = 1; $i -le $pages; $i++) {
#        $ubs = Invoke-RestMethod -Uri "http://api-ldc-hackathon.herokuapp.com/api/ubs/$i/"
#        $ubs.records
#     }
#} | ConvertTo-Json | Out-File -Encoding utf8 "C:\Users\enry_\Desktop\Hackaton JnJ\team5\sample.json"
$ubs = Get-Content -Path "C:\Users\enry_\Desktop\Hackaton JnJ\team5\sample.json" | ConvertFrom-Json


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

$ubs_mais_proxima = $null
[double]$menor_distancia = 2000
foreach ($u in $ubs) {
    [double]$distancia = Get-Distance -lat1 $lat -lon1 $lon -lat2 $u.vlr_latitude -lon2 $u.vlr_longitude
    if ($distancia -le $menor_distancia) {
        $menor_distancia = $distancia
        $ubs_mais_proxima = $u
    }
}
$ubs_mais_proxima