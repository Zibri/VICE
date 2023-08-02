var pty = require('node-pty');
const { spawn } = require('child_process');
const bat = spawn('cmd.exe', ['/c','setup.bat']);
bat.stdout.on('data', function (data) {
    process.stdout.write(data);
});
