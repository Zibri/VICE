@echo off
wsl --update
wsl --install -d openSUSE-Tumbleweed -n
rem "C:\Program Files\Git\usr\bin\timeout.exe" >NUL: 60s openSUSE-Tumbleweed >NUL: run
node -e "const{spawn}=require('child_process');bat=spawn('openSUSE-Tumbleweed',['--install','']);bat.stdout.on('data',function(data){if(data.indexOf('YaST')!=-1){bat.kill();}});bat.stderr.on('data',function(data){if(data.indexOf('YaST')!=-1){bat.kill();}});"
wsl --user root zypper refresh
cd %GITHUB_WORKSPACE%
dos2unix ossbuild.sh
dos2unix wsl.conf
wsl --user root cp wsl.conf /etc/wsl.conf
wsl --shutdown
wsl --user root ./ossbuild.sh
