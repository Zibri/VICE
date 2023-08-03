@echo off
wsl --update
wsl --install -d ubuntu -n
ubuntu install --root
wsl --user root -e apt update
wsl --user root -e apt upgrade -y
wsl --user root "./wslbuild.sh"
