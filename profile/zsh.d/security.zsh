# Security Tools
#
# WPSCAN
# https://github.com/wpscanteam/wpscan
# https://wpscan.com/how-to-install-wpscan

if command -v docker >/dev/null 2>&1; then
  alias wpscan='docker run -it --rm wpscanteam/wpscan'
fi
