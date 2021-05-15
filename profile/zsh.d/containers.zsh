# ~/.zshrc file for zsh interactive shells.
# see /usr/share/doc/zsh/examples/zshrc for examples

if [[ -f $(which docker) ]]; then
  alias kali='docker run --rm -ti kalilinux/kali bash'
  alias ubuntu='docker run --rm -ti ubuntu:latest bash'
  alias debian='docker run --rm -ti debian:10-slim bash'
  alias centos='docker run --rm -ti centos:8 bash'
fi
