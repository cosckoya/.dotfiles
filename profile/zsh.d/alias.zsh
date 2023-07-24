# Alias

if command -v docker >/dev/null 2>&1; then
  alias kali='docker run --rm -ti kalilinux/kali-rolling bash'
  alias ubuntu='docker run --rm -ti ubuntu:latest bash'
  alias debian='docker run --rm -ti debian:latest bash'
  alias centos='docker run --rm -ti centos:latest bash'
  alias archlinux='docker run --rm -ti archlinux:latest bash'
fi
