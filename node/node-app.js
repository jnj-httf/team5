const express = require('express');
const app = express();

var spawn = require("child_process").spawn, child;
const fs = require('fs');

app.use(express.static('node'));

let getCity = function (city) {
    console.log('running getcity');
    child = spawn("powershell.exe", ["C:\\Users\\enry_\\Desktop\\JnJ\\jnj-app\\src\\node\\PullCity.ps1 -city "+city.replace('+'," ")+" -outputpath \"C:\\Users\\enry_\\Desktop\\JnJ\\jnj-app\\src\\node\\outputCity.html\" "]);


    /* let onetime = true;

    child.stdout.on("data", function (data) {
        console.log("Powershell Data: " + data);
        if (onetime) {
            fs.truncate('outputCity.html', 0, function () { console.log('done') })
            onetime = false;
        }
        fs.appendFile("outputCity.html", data, function (err) {
            if (err) {
                return console.log(err);
            }
        });
    });*/
    child.stdin.end(); //end input
}

let getNearest = function(latitude, longitude) {
    console.log("running getnearest");
    child = spawn("powershell.exe", ["C:\\Users\\enry_\\Desktop\\JnJ\\jnj-app\\src\\node\\PullNearestUBS.ps1 -lat "+latitude+" -lon "+longitude+" -outputpath C:\\Users\\enry_\\Desktop\\JnJ\\jnj-app\\src\\node\\outputNearest.html"]);
    
    /* let onetime = true;

    child.stdout.on("data", function (data) {
        console.log("Powershell Data: " + data);
        if (onetime) {
            fs.truncate('outputNearest.html', 0, function () { console.log('done') })
            onetime = false;
        }
        fs.appendFile("outputNearest.html", data, function (err) {
            if (err) {
                return console.log(err);
                console.log('teste');
            }
        });
    });
    child.stdin.end(); //end input */
}


app.get('/', function (req, res) {
    res.send('index.html');
});

app.get('/city', function (req, res) {
    getCity(req.query.city);
  //res.send('Hello World!');
});

app.get('/nearest', function (req, res) {
    getNearest(req.query.latitude, req.query.longitude);
  //res.send('Hello World!');
});

app.listen(3007, function () {
  console.log('Example app listening on port 3000!');
});
