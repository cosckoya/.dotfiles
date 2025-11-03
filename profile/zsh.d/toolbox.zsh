# Toolbox: Download and run Docker-based development environment
# Repository: https://github.com/cosckoya/toolbox

toolbox() {
    local repo_url="https://raw.githubusercontent.com/cosckoya/toolbox/main/Dockerfile"
    local dockerfile_path="/tmp/toolbox-dockerfile"
    local image_name="toolbox-image"
    local container_name="toolbox-container"
    local workspace_dir="${HOME}/hack"
    local force_rebuild=false
    local no_cache=false

    # Parse options
    while [[ $# -gt 0 ]]; do
        case $1 in
            -f|--force) force_rebuild=true; shift ;;
            --no-cache) no_cache=true; shift ;;
            -h|--help)
                cat << EOF
Usage: toolbox [OPTIONS] [COMMAND]

Downloads and runs the latest toolbox from:
https://github.com/cosckoya/toolbox

Options:
  -f, --force     Force rebuild even if image exists
  --no-cache      Build without using Docker cache
  -h, --help      Show this help

Examples:
  toolbox                    # Interactive shell
  toolbox ls -la             # Run specific command
  toolbox --force            # Force rebuild and run
EOF
                return 0
                ;;
            *) break ;;
        esac
    done

    # Check if image exists
    if docker image inspect "$image_name" >/dev/null 2>&1 && [[ "$force_rebuild" == false ]]; then
        echo "🚀 Using existing toolbox image (use --force to rebuild)"
    else
        echo "🔧 Downloading latest Dockerfile..."
        curl -fsSL "$repo_url" -o "$dockerfile_path" || {
            echo "❌ Failed to download Dockerfile"
            return 1
        }

        echo "🔨 Building toolbox image..."
        local build_args=($([[ "$no_cache" == true ]] && echo "--no-cache"))
        docker build ${build_args[@]} -f "$dockerfile_path" -t "$image_name" /tmp || {
            echo "❌ Build failed!"
            rm -f "$dockerfile_path"
            return 1
        }
        rm -f "$dockerfile_path"
        echo "✅ Build completed successfully"
    fi

    # Run container
    mkdir -p "$workspace_dir"
    docker run -it --rm \
        --name "${container_name}-$(date +%s)" \
        -v "$workspace_dir":/hack \
        -w /hack \
        -e "PS1=\[\033[01;32m\]toolbox\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ " \
        "$image_name" "$@"
}
