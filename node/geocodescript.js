var spawn = require("child_process").spawn,child;
child = spawn("powershell.exe",["C:\\Users\\gabri\\Documents\\Projetos\\team5\\node\\PullJson.ps1"]);

child.stdout.on("data",function(data){
    console.log("Powershell Data: " + data);
    module.exports = data;
});
child.stderr.on("data",function(data){
    console.log("Powershell Errors: " + data);
});
child.on("exit",function(){
    console.log("Powershell Script finished");
});
child.stdin.end(); //end input