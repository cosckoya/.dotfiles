# Aliases - Lazy-loaded for speed (no command checks at startup)

# Docker container aliases - lazy load
kali() { docker run --rm -ti kalilinux/kali-rolling bash "$@"; }
parrot() { docker run --rm -ti parrotsec/core bash "$@"; }
debian() { docker run --rm -ti debian:latest bash "$@"; }
archlinux() { docker run --rm -ti archlinux:latest bash "$@"; }
wpscan() { docker run -it --rm wpscanteam/wpscan "$@"; }
nikto() { docker run --rm -ti secfigo/nikto "$@"; }
nuclei() { docker run --rm -ti projectdiscovery/nuclei "$@"; }
metasploit() { docker run --rm -ti -v "${HOME}/.msf4:/root/.msf4" metasploitframework/metasploit-framework "$@"; }
zap() { docker run --rm -ti -u zap -p 8080:8080 -v "${HOME}/.ZAP:/zap/wrk" zaproxy/zap-stable zap-webswing.sh "$@"; }
zap-cli() { docker run --rm -ti -v "${HOME}/.ZAP:/zap/wrk" zaproxy/zap-stable "$@"; }

# Better cat - conditional alias
[[ -x /usr/bin/batcat ]] && alias cat='batcat --theme=TwoDark'
