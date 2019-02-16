﻿param (
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

$ubs | Where-Object { !$city -or $_.dsc_cidade -imatch "$city.*" } | Select-Object -ExpandProperty dsc_cidade -Unique | Sort-Object