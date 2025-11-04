# Aliases

# Docker container aliases
if command -v docker >/dev/null 2>&1; then
  # Linux distributions
  alias kali='docker run --rm -ti kalilinux/kali-rolling bash'
  alias parrot='docker run --rm -ti parrotsec/core bash'
  alias debian='docker run --rm -ti debian:latest bash'
  alias archlinux='docker run --rm -ti archlinux:latest bash'

  # Security tools
  alias wpscan='docker run -it --rm wpscanteam/wpscan'
  alias nikto='docker run --rm -ti secfigo/nikto'
  alias nuclei='docker run --rm -ti projectdiscovery/nuclei'
  alias metasploit='docker run --rm -ti -v "${HOME}/.msf4:/root/.msf4" metasploitframework/metasploit-framework'
  alias zap='docker run --rm -ti -u zap -p 8080:8080 -v "${HOME}/.ZAP:/zap/wrk" zaproxy/zap-stable zap-webswing.sh'
  alias zap-cli='docker run --rm -ti -v "${HOME}/.ZAP:/zap/wrk" zaproxy/zap-stable'
fi

# Better cat with syntax highlighting
if command -v batcat >/dev/null 2>&1; then
  alias cat='batcat --theme=TwoDark'
fi
