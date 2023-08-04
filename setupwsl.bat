@echo off
wsl --update
wsl --install -d ubuntu -n
ubuntu install --root
wsl --user root -e apt update
wsl --user root -e apt upgrade -y
cd %GITHUB_WORKSPACE%
wsl --user root -e ls -al
dos2unix wslbuild.sh
dos2unix wsl.conf
wsl --user root cp wsl.conf /etc/wsl.conf
wsl --shutdown
wsl --user root ./wslbuild.sh
