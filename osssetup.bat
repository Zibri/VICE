@echo off
wsl --update
wsl --install -d openSUSE-Tumbleweed -n
node -e "const{spawn}=require('child_process');bat=spawn('openSUSE-Tumbleweed',['--install','']);bat.stdout.on('data',function(data){if(data.indexOf('YaST')!=-1){bat.kill();}});bat.stderr.on('data',function(data){if(data.indexOf('YaST')!=-1){bat.kill();}});"
wsl --user root zypper refresh
cd %GITHUB_WORKSPACE%
dos2unix ossbuild.sh
dos2unix wsl.conf
dos2unix installer.sh
wsl --user root cp wsl.conf /etc/wsl.conf
wsl --shutdown
wsl --user root ./ossbuild.sh
