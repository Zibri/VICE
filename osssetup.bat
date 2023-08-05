@echo off
wsl --update
wsl --install -d openSUSE-Tumbleweed -n
"C:\Program Files\Git\usr\bin\timeout.exe" >NUL: 60s openSUSE-Tumbleweed >NUL: run
wsl --user root zypper refresh
cd %GITHUB_WORKSPACE%
dos2unix ossbuild.sh
dos2unix wsl.conf
wsl --user root cp wsl.conf /etc/wsl.conf
wsl --shutdown
wsl --user root ./ossbuild.sh
