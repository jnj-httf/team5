#Run as administrator

param (
    [switch]$debug = $true
)

if ($debug.IsPresent) { $VerbosePreference = "Continue" }
else                  { $VerbosePreference = "SilentlyContinue" }


Import-Module "$(Split-Path $script:MyInvocation.MyCommand.Path | Join-Path -ChildPath "PSIS\PSWebServer.psm1")" -Global


Write-Verbose "Starint Web Server"
Start-PSWebServer -ProcessRequest {

    [string]$output = "" 
    [string]$path = "$env:TEMP\ubs.json"
        
    if ($Request.RawUrl -ne "/") {

        if (!$ubs) {
            #Build cache file if one does not exist
            if ((Test-Path -Path $path)) {
                Write-Verbose "Reading cache file from $path"
                $ubs = Get-Content -Path $path | ConvertFrom-Json
            }
            else {
                Write-Error "Cache file not found. Building it" -ErrorAction Continue

                Write-Verbose "Getting number of pages to fetch"
                [int]$pages = (Invoke-RestMethod -Uri "http://api-ldc-hackathon.herokuapp.com/api/ubs/" | Select-Object -ExpandProperty _metadata | Select-Object -ExpandProperty page) -split "/" | Select-Object -Last 1

                Write-Verbose "Fetching pages"
                $ubs = Invoke-Command {
                     for ($i = 1; $i -le $pages; $i++) {
                        $ubs_page = Invoke-RestMethod -Uri "http://api-ldc-hackathon.herokuapp.com/api/ubs/$i/"
                        $ubs_page.records
                     }
                }
                Write-Verbose "Writing cache file to $path"
                $ubs | ConvertTo-Json | Out-File -Encoding utf8 $path
            }
        }
        else {
            Write-Verbose "Reusing cached data"
        }

        #Function definition to remove accents and multiple spaces from string
        function Remove-Accents {
            param ([string]$s)
            $s -ireplace "[áã]", "a" -ireplace "[éê]", "e" -ireplace "[í]", "i" -ireplace "[óôõ]", "0" -ireplace "[ú]", "u" -ireplace "[ç]", "c" -ireplace "\s+", " "
        }


        # 
        # "Se regra de três não resolver, tente Pitágoras" grigt
        # 
        #Function definition to get distance between two points
        function Get-Distance {
            param (
                [double]$lat1, [double]$lon1, [double]$lat2, [double]$lon2
            )
            [double]$c1 = ($lat2 - $lat1)
            [double]$c2 = ($lon2 - $lon1)
            [Math]::Sqrt($c1*$c1 + $c2*$c2)
        }

        if ($Request.RawUrl -imatch "^/PullCity") {
            Write-Verbose "PullCity Requested"
            $City = [System.Web.HttpUtility]::ParseQueryString($Request.Url.query)["City"]
            Write-Verbose "PullCity Requested for City $City"
            #Return city found
            $output = $ubs | Where-Object { (Remove-Accents -s $_.dsc_cidade) -imatch "$(Remove-Accents -s $City).*" } | ConvertTo-Html -Property dsc_cidade, nom_estab, dsc_endereco, dsc_bairro -Fragment
        }
        elseif ($Request.RawUrl -imatch "^/PullNearestUBS") {
            Write-Verbose "PullNearestUBS Requested"
            $lat = [System.Web.HttpUtility]::ParseQueryString($Request.Url.query)["Lat"]
            $lon = [System.Web.HttpUtility]::ParseQueryString($Request.Url.query)["Lon"]
            Write-Verbose "PullNearestUBS Requested for Latitude $Lat and Longitude $Lon"
            if ($lat -and $lon) {
                $ubs_mais_proxima = $null
                [double]$menor_distancia = 2000 # Set a large number
                foreach ($u in $ubs) {
                    [double]$distancia = Get-Distance -lat1 $lat -lon1 $lon -lat2 $u.vlr_latitude -lon2 $u.vlr_longitude

                    #Test if ubs distance is lower
                    if ($distancia -le $menor_distancia) {
                        $menor_distancia = $distancia
                        $ubs_mais_proxima = $u
                    }
                }
                #Return city found
                $output = $ubs_mais_proxima | ConvertTo-Html -Property dsc_cidade, nom_estab, dsc_endereco, dsc_bairro -Fragment
            }
        }
    }

     "
    <!DOCTYPE html PUBLIC ""-//W3C//DTD XHTML 1.0 Strict//EN""  ""http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"">
    <html xmlns=""http://www.w3.org/1999/xhtml"">
    <head>
    <title>HTML TABLE</title>
    </head><body>
    <form action=""/PullCity"" method=""get"">
        Cidade:<br>
        <input type=""text"" name=""City""><br>
        <input type=""submit"" value=""Busca UBS por Cidade""><br>
        <br>
    </form>
    <form action=""/PullNearestUBS"" method=""get"">
        Latitude:<br>
        <input type=""text"" name=""Lat""><br>
        Longitude:<br>
        <input type=""text"" name=""Lon""><br>
        <input type=""submit"" value=""Busca UBS mais proxima""><br>
        <br>
    </form>
    $output
    </body></html>"
}