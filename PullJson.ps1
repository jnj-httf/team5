Invoke-WebRequest -Uri http://api-ldc-hackathon.herokuapp.com/api/ubs/#/ | Select-Object -ExpandProperty Content | Out-File -Encoding utf8 "C:\Users\enry_\Desktop\Hackaton JnJ\team5\sample.json"
