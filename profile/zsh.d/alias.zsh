# Alias

if command -v docker >/dev/null 2>&1; then
  alias kali='docker run --rm -ti kalilinux/kali-rolling bash'
  alias debian='docker run --rm -ti debian:latest bash'
fi
