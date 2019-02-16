[int]$pages = (Invoke-RestMethod -Uri "http://api-ldc-hackathon.herokuapp.com/api/ubs/" | Select-Object -ExpandProperty _metadata | Select-Object -ExpandProperty page) -split "/" | Select-Object -Last 1

Invoke-Command {
     for ($i = 1; $i -le $pages; $i++) {
        $ubs = Invoke-RestMethod -Uri "http://api-ldc-hackathon.herokuapp.com/api/ubs/$i/"
        $ubs.records 
     }
} | Sort-Object -Property dsc_cidade | ConvertTo-Html -Property dsc_cidade, nom_estab, dsc_endereco, dsc_bairro | Out-File -FilePath "C:\Users\enry_\Desktop\Hackaton JnJ\team5\city-ubs.html"
