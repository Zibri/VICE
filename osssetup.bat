@echo off
wsl --update
wsl --install -d openSUSE-Tumbleweed -n
node -e "const{spawn}=require('child_process');bat=spawn('openSUSE-Tumbleweed',['--install','']);bat.stdout.on('data',function(data){if(data.indexOf('YaST')!=-1){bat.kill();}});bat.stderr.on('data',function(data){if(data.indexOf('YaST')!=-1){bat.kill();}});"
wsl --user root zypper refresh
wsl --user root zypper -n up glibc glibc-locale-base libcap-ng0 libcap2 libcares2 libcom_err2 libcrack2 libcrypt1 libcryptsetup12 libcurl4 libglib-2_0-0 libmagic1 libmetalink3 libmnl0 libmount1 libmpdec3 libmpfr6 libstdc++6 libz1 libzck1 libzio1 libzstd1 libzypp
cd %GITHUB_WORKSPACE%
dos2unix ossbuild.sh
dos2unix wsl.conf
dos2unix installer.sh
dos2unix vice_update_opensuse.sh
wsl --user root cp wsl.conf /etc/wsl.conf
wsl --shutdown
wsl --user root ./ossbuild.sh
