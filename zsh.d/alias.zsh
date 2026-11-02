# Aliases - Lazy-loaded for speed (no command checks at startup)

# Docker container aliases - lazy load
# Images pinned by digest for supply chain security.
# Update digests: docker pull <image> && docker inspect --format='{{index .RepoDigests 0}}' <image>
kali() { docker run --rm -ti kalilinux/kali-rolling@sha256:7997e0581c4f5c185cfe6773d5cae8fcc7c6b79798726ccaabf843af4bcd2013 bash "$@"; }
parrot() { docker run --rm -ti parrotsec/core@sha256:2dcefa48d3c4ae6b1a1a1391ae2a0ae6115a3c194b3677b3f0487f0e3996c9cd bash "$@"; }
debian() { docker run --rm -ti debian@sha256:2dc419c6d7fe3dad0a2f9fd469c34cc90b0f9ba642d8fde837fe3d7d34a0e7f1 bash "$@"; }
archlinux() { docker run --rm -ti archlinux@sha256:e82623936fa1a69700b48e98b058df6eaab18b737c27473a7234a40fdecb9413 bash "$@"; }
wpscan() { docker run -it --rm wpscanteam/wpscan@sha256:ae7685d5d6cbd86956ba4cb45b9e14ab808c45096b10a751252a9a1044c3764d "$@"; }
nikto() { docker run --rm -ti secfigo/nikto@sha256:fdb9c08ee732d6ef85c4321c276af0acacc6bcf478980540387ef80ba1818799 "$@"; }
nuclei() { docker run --rm -ti projectdiscovery/nuclei@sha256:582d5546902e67052097cb2d07296c642d50a1afc5e44623cb038845df9a32eb "$@"; }
metasploit() { docker run --rm -ti -v "${HOME}/.msf4:/root/.msf4" metasploitframework/metasploit-framework@sha256:b1c4950615fec43bdbe915de7de4b144a24803b21765b86cf0df52799ab08776 "$@"; }
zap() { docker run --rm -ti -u zap -p 8080:8080 -v "${HOME}/.ZAP:/zap/wrk" zaproxy/zap-stable@sha256:030d3df57735dacbb83464854758e674dd9ad01d79d12a129a8e58b1fd384238 zap-webswing.sh "$@"; }
zap-cli() { docker run --rm -ti -v "${HOME}/.ZAP:/zap/wrk" zaproxy/zap-stable@sha256:030d3df57735dacbb83464854758e674dd9ad01d79d12a129a8e58b1fd384238 "$@"; }

# Better cat - conditional alias
[[ -x /usr/bin/batcat ]] && alias cat='batcat'
