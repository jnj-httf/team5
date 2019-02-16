var spawn = require("child_process").spawn, child;
const fs = require('fs');

module.exports = function (city) {
    child = spawn("powershell.exe", ["C:\\Users\\enry_\\Desktop\\JnJ\\jnj-app\\src\\node\\PullCity.ps1 -city "+city+" "]);


    let onetime = true;

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
            console.log("The file was saved!");
        });
    });
    child.stdin.end(); //end input
}

