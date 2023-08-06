@echo off
wsl --update
wsl --install -d ubuntu -n
ubuntu install --root
wsl --user root -e apt update
rem wsl --user root -e apt upgrade -y
cd %GITHUB_WORKSPACE%
dos2unix wslbuild.sh
dos2unix wsl.conf
dos2unix installer.sh
wsl --user root cp wsl.conf /etc/wsl.conf
wsl --shutdown
wsl --user root ./wslbuild.sh
