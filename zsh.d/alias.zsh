# Aliases - Lazy-loaded for speed (no command checks at startup)

# Docker container aliases - lazy load
# Images pinned by digest for supply chain security.
# Update digests: docker pull <image> && docker inspect --format='{{index .RepoDigests 0}}' <image>
kali() { docker run --rm -ti kalilinux/kali-rolling@sha256:PLACEHOLDER_DIGEST_KALI bash "$@"; }
parrot() { docker run --rm -ti parrotsec/core@sha256:PLACEHOLDER_DIGEST_PARROT bash "$@"; }
debian() { docker run --rm -ti debian@sha256:PLACEHOLDER_DIGEST_DEBIAN bash "$@"; }
archlinux() { docker run --rm -ti archlinux@sha256:PLACEHOLDER_DIGEST_ARCH bash "$@"; }
wpscan() { docker run -it --rm wpscanteam/wpscan@sha256:PLACEHOLDER_DIGEST_WPSCAN "$@"; }
nikto() { docker run --rm -ti secfigo/nikto@sha256:PLACEHOLDER_DIGEST_NIKTO "$@"; }
nuclei() { docker run --rm -ti projectdiscovery/nuclei@sha256:PLACEHOLDER_DIGEST_NUCLEI "$@"; }
metasploit() { docker run --rm -ti -v "${HOME}/.msf4:/root/.msf4" metasploitframework/metasploit-framework@sha256:PLACEHOLDER_DIGEST_MSF "$@"; }
zap() { docker run --rm -ti -u zap -p 8080:8080 -v "${HOME}/.ZAP:/zap/wrk" zaproxy/zap-stable@sha256:PLACEHOLDER_DIGEST_ZAP zap-webswing.sh "$@"; }
zap-cli() { docker run --rm -ti -v "${HOME}/.ZAP:/zap/wrk" zaproxy/zap-stable@sha256:PLACEHOLDER_DIGEST_ZAP_CLI "$@"; }

# Better cat - conditional alias
[[ -x /usr/bin/batcat ]] && alias cat='batcat --theme=TwoDark'
